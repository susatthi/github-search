// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:github_search/domain/entities/query_history.dart';
import 'package:github_search/domain/entities/query_history_input.dart';
import 'package:github_search/domain/repositories/query_history_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'logger.dart';
import 'utils.dart';

/// モック版のHTTPクライアント
final mockHttpClient = MockClient(
  (request) async {
    final host = request.url.host;
    var path = request.url.path;
    if (path.startsWith('/')) {
      path = path.replaceFirst('/', '');
    }

    testLogger.i('Called request: host = $host, path = $path');

    // 任意のステータスコードを返す
    final statusCode = int.tryParse(path);
    if (statusCode != null) {
      testLogger.i('Return error: statusCode = $statusCode');
      return http.Response('$statusCode', statusCode);
    }

    // SocketExceptionを発生させる
    if (path.contains('socketException')) {
      testLogger.i('Throw SocketException');
      throw const SocketException('');
    }

    if (host == 'api.github.com') {
      // リポジトリ検索
      if (path == 'search/repositories') {
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
      }

      // リポジトリ取得
      final reg = RegExp(r'^repos\/(.+)\/(.+)');
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
      }
    } else if (host == 'raw.githubusercontent.com') {
      final parts = path.split('/');
      if (parts.length == 4) {
        final ownerName = parts[0];
        final repoName = parts[1];
        final branchName = parts[2];
        final fileName = parts[3];

        // MDファイル名を生成する
        final mdFileNameBuffer = StringBuffer('get_readme')
          ..write('_$ownerName')
          ..write('_$repoName')
          ..write('_$branchName')
          ..write('_$fileName');

        // MDファイルのパス
        final mdFilePath = 'github/${mdFileNameBuffer.toString()}';
        testLogger.i('Required md file at $mdFilePath');

        // 検索文字列からテスト用のMDファイルを読み込む
        final mdString = TestAssets.readString(mdFilePath);
        if (mdString != null) {
          return http.Response(
            mdString,
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
            },
          );
        }
      }

      // 404 を返す
      return http.Response('', 404);
    }

    throw AssertionError('Invalid test request: path=$path');
  },
);

/// 常にエラーを返すモック版のHTTPクライアント
final mockHttpClientError = MockClient(
  (request) async {
    throw const SocketException('');
  },
);

/// モック版のGoRouter
class MockGoRouter extends Mock implements GoRouter {}

/// モック版のUrlLauncherPlatform
class MockUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

/// 常にエラーを返すモック版のQueryHistoryRepository
class MockQueryHistoryRepositoryError implements QueryHistoryRepository {
  @override
  Future<void> add(QueryHistoryInput input) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(QueryHistory query) {
    throw UnimplementedError();
  }

  @override
  Future<List<QueryHistory>> findByQueryString(String queryString) {
    throw UnimplementedError();
  }
}

/// モック版のPathProviderPlatform
class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  final rootDir = Directory(
    path.join(
      Directory.current.path,
      '.dart_tool',
      'test',
      'tmp',
      'path_provider',
    ),
  );

  @override
  Future<String> getTemporaryPath() async {
    return Directory(path.join(rootDir.path, 'temporary')).path;
  }

  @override
  Future<String> getApplicationSupportPath() async {
    return Directory(path.join(rootDir.path, 'application_support')).path;
  }

  @override
  Future<String> getLibraryPath() async {
    return Directory(path.join(rootDir.path, 'library')).path;
  }

  @override
  Future<String> getApplicationDocumentsPath() async {
    return Directory(path.join(rootDir.path, 'application_documents')).path;
  }

  @override
  Future<String> getExternalStoragePath() async {
    return Directory(path.join(rootDir.path, 'external_storage')).path;
  }

  @override
  Future<List<String>> getExternalCachePaths() async {
    return [Directory(path.join(rootDir.path, 'external_cache')).path];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return [Directory(path.join(rootDir.path, 'external_storage')).path];
  }

  @override
  Future<String> getDownloadsPath() async {
    return Directory(path.join(rootDir.path, 'downloads')).path;
  }
}
