// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/src/config/app.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_search_text_field.dart';
import 'package:github_search/src/repositories/github/api.dart';
import 'package:github_search/src/repositories/github/http_client.dart';
import 'package:github_search/src/repositories/github/repo_repository.dart';
import 'package:github_search/src/repositories/repo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../utils/assets.dart';

/// モック版のHTTPクライアント
final mockHttpClient = MockClient(
  (request) async {
    final path = request.url.path;

    // リポジトリ検索
    if (path == '/search/repositories') {
      final query = request.url.queryParameters['q'];
      final page = request.url.queryParameters['page'] ?? 1;

      // 検索文字列からテスト用のJSONファイルを読み込む
      final jsonString = TestAssets.readString(
        'github/search_repos_${query}_page$page.json',
      );
      if (jsonString != null) {
        return http.Response(
          jsonString,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        );
      }
      throw AssertionError('Invalid test request: path=$path');
    }

    // リポジトリ取得
    final reg = RegExp(r'^\/repos\/(.+)\/(.+)');
    if (reg.hasMatch(path)) {
      final ownerName = reg.allMatches(path).map((e) => e.group(1)).first;
      final repoName = reg.allMatches(path).map((e) => e.group(2)).first;

      // ownerName/repoNameからテスト用のJSONファイルを読み込む
      final jsonString = TestAssets.readString(
        'github/get_repo_${ownerName}_$repoName.json',
      );
      if (jsonString != null) {
        return http.Response(
          jsonString,
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        );
      }
      throw AssertionError('Invalid test request: path=$path');
    }

    // 任意のステータスコードを返す
    final statusCode = int.tryParse(path);
    if (statusCode != null) {
      return http.Response('$statusCode', statusCode);
    }

    // SocketExceptionを発生させる
    if (path == 'socketException') {
      throw const SocketException('');
    }

    throw AssertionError('Invalid test request: path=$path');
  },
);

/// モック版のGithubHttpClient
final mockGithubHttpClient =
    GithubHttpClient(token: 'dummy', client: mockHttpClient);

/// モック版のGithubRepoRepository
final mockGithubRepoRepository = GithubRepoRepository(
  api: const GithubApi(),
  client: mockGithubHttpClient,
);

/// モック版のGithubSearchApp
final mockApp = ProviderScope(
  overrides: [
    // モック版のGithubHttpClientを使う
    repoRepositoryProvider.overrideWithProvider(
      Provider<RepoRepository>(
        (ref) {
          return mockGithubRepoRepository;
        },
      ),
    ),
    // リポジトリ検索文字列の初期値を設定する
    searchReposQueryProvider.overrideWithProvider(
      StateProvider<String>((ref) => 'flutter'),
    ),
  ],
  child: GithubSearchApp(),
);
