// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repo/entities/repo_data.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/json_object/repo/repo.dart';
import 'package:github_search/presentation/repo/components/readme_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';
import '../../../test_utils/utils.dart';
import '../../common/components/cached_circle_avatar_test.dart';

class FakeHttpClient extends Fake implements HttpClient {
  FakeHttpClient(this.request);

  FakeHttpClientRequest request;

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

class FakeHttpClientRequest extends Fake implements HttpClientRequest {
  FakeHttpClientRequest(this.response);

  FakeHttpClientResponse response;

  @override
  final HttpHeaders headers = FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => response;
}

class FakeHttpClientResponse extends Fake implements HttpClientResponse {
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

void main() {
  late RepoData repo;
  late MockUrlLauncherPlatform mockUrlLauncherPlatform;
  setUp(() {
    repo = RepoData.from(
      Repo.fromJson(
        TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
      ),
    );
    mockUrlLauncherPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
    useEnvironmentLocale();
  });

  group('RepoReadmeMarkdown', () {
    testWidgets('画像取得時にエラーが起きたときはSVGとして取得を試みるはず', (tester) async {
      // 参考サイト: https://github.com/dnfield/flutter_svg/blob/master/test/widget_svg_test.dart

      final repo = RepoData.from(
        Repo.fromJson(
          TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
        ),
      );
      final mockCacheManager = MockDefaultCacheManager();

      PictureProvider.cache.clear();
      svg.cacheColorFilterOverride = null;
      final fakeResponse = FakeHttpClientResponse();
      final fakeRequest = FakeHttpClientRequest(fakeResponse);
      final fakeHttpClient = FakeHttpClient(fakeRequest);

      await HttpOverrides.runZoned(
        () async {
          await tester.pumpWidget(
            mockGitHubSearchApp(
              home: SingleChildScrollView(
                child: RepoReadmeMarkdown(
                  repo: repo,
                  cacheManager: mockCacheManager,
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          // SvgPictureがあるはず
          expect(find.byType(SvgPicture), findsOneWidget);

          await fakeRequest.close();
        },
        createHttpClient: (SecurityContext? c) => fakeHttpClient,
      );
    });
    testWidgets('必要なWidgetが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      // 最初はローディングを表示するはず
      expect(find.byType(LottieBuilder), findsOneWidget);
      expect(find.byType(MarkdownBody), findsNothing);

      await tester.pump();

      // Markdownを表示するはず
      expect(find.byType(LottieBuilder), findsNothing);
      expect(find.byType(MarkdownBody), findsOneWidget);
    });
    testWidgets('通信エラー時は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      // 最初はローディングを表示するはず
      expect(find.byType(LottieBuilder), findsOneWidget);
      expect(find.byType(MarkdownBody), findsNothing);

      await tester.pump();

      // Markdownを表示しないはず
      expect(find.byType(LottieBuilder), findsNothing);
      expect(find.byType(MarkdownBody), findsNothing);
    });
    testWidgets('リンクをタップしてブラウザを開けるはず', (tester) async {
      const urlString = 'https://keyber.jp/';
      when(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => true);

      final repo = RepoData.from(
        Repo.fromJson(
          TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
        ),
      );
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      await tester.pump();

      // リンクをタップする
      await tester.tap(find.text('リンク'));
      await tester.pump();

      verify(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).called(1);
    });
  });
}
