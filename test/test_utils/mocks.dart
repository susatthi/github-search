// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history_input.dart';
import 'package:github_search/domain/repositories/query_history/query_history_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
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

/// モック版のCacheManager
class MockCacheManager extends Mock implements DefaultCacheManager {
  static const fileSystem = LocalFileSystem();

  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    testLogger.v('Requested image: url = $url');
    if (url.isNotEmpty) {
      // URLが空でなければダミー画像を返す
      yield FileInfo(
        fileSystem.file('./test/test_utils/assets/github/13707135.png'),
        FileSource.Cache,
        DateTime(2050),
        url,
      );
      testLogger.v('Returned image file: url = $url');
      return;
    }

    // URLが空ならエラーを投げる
    testLogger.v('Throw not found');
    throw Exception('Not found');
  }
}

/// 常に小さい画像を返すモック版のCacheManager
class MockCacheManagerSmall extends Mock implements DefaultCacheManager {
  static const fileSystem = LocalFileSystem();

  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    testLogger.v('[Small] Requested image: url = $url');
    if (url.isNotEmpty) {
      // URLが空でなければダミー画像を返す
      yield FileInfo(
        fileSystem.file('./test/test_utils/assets/github/small.png'),
        FileSource.Cache,
        DateTime(2050),
        url,
      );
      testLogger.v('[Small] Returned image file: url = $url');
      return;
    }

    // URLが空ならエラーを投げる
    testLogger.v('[Small] Throw not found');
    throw Exception('Not found');
  }
}

/// 常にエラーを返すCacheManager
class MockCacheManagerError extends Mock implements DefaultCacheManager {
  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    // 常にエラーを投げる
    throw Exception('[Error] Not found');
  }
}

class FakeSvgHttpClient extends Fake implements HttpClient {
  FakeSvgHttpClient(this.request);

  FakeSvgHttpClientRequest request;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => request;
}

class FakeHttpHeaders extends Fake implements HttpHeaders {
  final Map<String, String?> values = <String, String?>{};

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    values[name] = value.toString();
  }

  @override
  List<String>? operator [](String key) {
    return <String>[values[key]!];
  }
}

class FakeSvgHttpClientRequest extends Fake implements HttpClientRequest {
  FakeSvgHttpClientRequest(this.response);

  FakeSvgHttpClientResponse response;

  @override
  final HttpHeaders headers = FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => response;
}

class FakeSvgHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int statusCode = 200;

  @override
  int contentLength = svgStr.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<Uint8List>.fromIterable(<Uint8List>[svgBytes]).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }
}

const String svgStr = '''
<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 166 202">
  <defs>
      <linearGradient id="triangleGradient">
          <stop offset="20%" stop-color="#000000" stop-opacity=".55" />
          <stop offset="85%" stop-color="#616161" stop-opacity=".01" />
      </linearGradient>
      <linearGradient id="rectangleGradient" x1="0%" x2="0%" y1="0%" y2="100%">
          <stop offset="20%" stop-color="#000000" stop-opacity=".15" />
          <stop offset="85%" stop-color="#616161" stop-opacity=".01" />
      </linearGradient>
  </defs>
  <path fill="#42A5F5" fill-opacity=".8" d="M37.7 128.9 9.8 101 100.4 10.4 156.2 10.4"/>
  <path fill="#42A5F5" fill-opacity=".8" d="M156.2 94 100.4 94 79.5 114.9 107.4 142.8"/>
  <path fill="#0D47A1" d="M79.5 170.7 100.4 191.6 156.2 191.6 156.2 191.6 107.4 142.8"/>
  <g transform="matrix(0.7071, -0.7071, 0.7071, 0.7071, -77.667, 98.057)">
      <rect width="39.4" height="39.4" x="59.8" y="123.1" fill="#42A5F5" />
      <rect width="39.4" height="5.5" x="59.8" y="162.5" fill="url(#rectangleGradient)" />
  </g>
  <path d="M79.5 170.7 120.9 156.4 107.4 142.8" fill="url(#triangleGradient)" />
</svg>
''';

final Uint8List svgBytes = utf8.encode(svgStr) as Uint8List;

Future<void> fakeSvg(Future<void> Function() body) async {
  PictureProvider.cache.clear();
  svg.cacheColorFilterOverride = null;
  final fakeResponse = FakeSvgHttpClientResponse();
  final fakeRequest = FakeSvgHttpClientRequest(fakeResponse);
  final fakeHttpClient = FakeSvgHttpClient(fakeRequest);
  await HttpOverrides.runZoned(
    () async {
      await body();
      await fakeRequest.close();
    },
    createHttpClient: (SecurityContext? c) => fakeHttpClient,
  );
}
