// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_text_field.dart';
import 'package:github_search/repositories/github/api.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:github_search/repositories/github/repo_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'logger.dart';
import 'utils.dart';

/// モック版のHTTPクライアント
final mockHttpClient = MockClient(
  (request) async {
    final path = request.url.path;

    // リポジトリ検索
    if (path == '/search/repositories') {
      final query = request.url.queryParameters['q'];
      final page = request.url.queryParameters['page'] ?? 1;
      final sort = request.url.queryParameters['sort'];

      // JSONファイル名を生成する
      final jsonFileNameBuffer = StringBuffer('search_repos_')
        ..write(query)
        ..write('_page$page');
      if (sort != null) {
        jsonFileNameBuffer.write('_$sort');
      }
      jsonFileNameBuffer.write('.json');

      // JSONファイルのパス
      final jsonFilePath = 'github/${jsonFileNameBuffer.toString()}';
      testLogger.i('Required json file at $jsonFilePath');

      // 検索文字列からテスト用のJSONファイルを読み込む
      final jsonString = TestAssets.readString(jsonFilePath);
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

/// モック版のGitHubHttpClient
final mockGitHubHttpClient =
    GitHubHttpClient(token: 'dummy', client: mockHttpClient);

/// モック版のGitHubRepoRepository
final mockGitHubRepoRepository = GitHubRepoRepository(
  api: const GitHubApi(),
  client: mockGitHubHttpClient,
);

/// モック版のGitHubSearchApp
final mockGitHubSearchApp = ProviderScope(
  overrides: [
    // モック版のGitHubHttpClientを使う
    repoRepositoryProvider.overrideWithValue(mockGitHubRepoRepository),
    // リポジトリ検索文字列の初期値を設定する
    searchReposQueryProvider.overrideWithProvider(
      StateProvider<String>((ref) => 'flutter'),
    ),
  ],
  child: const GitHubSearchApp(),
);
