// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/repo/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';
import 'package:github_search/presentation/page/repo/component/readme_markdown.dart';
import 'package:lottie/lottie.dart';

import '../../../../test_utils/golden_testing_tools.dart';
import '../../../../test_utils/logger.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';
import '../../../../test_utils/utils.dart';

void main() {
  final repo = GitHubRepoRepository.repoBuilder(
    RepoJsonObject.fromJson(
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
    ),
  );

  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);
  group('readmeMarkdownCacheManagerProvider', () {
    test('初期値はnullのはず', () async {
      final container = ProviderContainer();
      final cacheManager = container.read(readmeMarkdownCacheManagerProvider);
      expect(cacheManager, isNull);
    });
    testWidgets('nullだとデフォルトのCacheManagerが使われるはず', (tester) async {
      await fakeSvg(() async {
        await tester.pumpWidget(
          agent.mockApp(
            overrides: [
              readmeMarkdownCacheManagerProvider.overrideWithValue(null),
            ],
            home: SingleChildScrollView(
              child: ReadmeMarkdown(
                repo: repo,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final cachedNetworkImage = tester
            .widget<CachedNetworkImage>(find.byType(CachedNetworkImage).last);
        final cacheManager = cachedNetworkImage.cacheManager as CacheManager?;
        expect(cacheManager?.store.storeKey, 'ReadmeMarkdownKey');
      });
    });
  });
  group('repoReadmeContentProvider', () {
    test('正常にREADMEコンテンツが取得できるはず', () async {
      // 初期値はAsyncLoading
      var asyncValue = agent
          .mockContainer()
          .listen(
            readmeContentProviderFamily(repo),
            (previous, next) {},
          )
          .read();
      expect(asyncValue is AsyncLoading, true);
      expect(asyncValue.value, isNull);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      asyncValue = agent
          .mockContainer()
          .listen(
            readmeContentProviderFamily(repo),
            (previous, next) {},
          )
          .read();
      expect(asyncValue is AsyncData, true);
      expect(asyncValue.value, isNotNull);
    });
    test('通信エラー時はAsyncErrorのはず', () async {
      var asyncValue = agent
          .mockContainer(
            overrides: [
              // 常にエラーを返すHTTPクライアントを使う
              httpClientProvider.overrideWithValue(mockHttpClientError),
            ],
          )
          .listen(
            readmeContentProviderFamily(repo),
            (previous, next) {},
          )
          .read();

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // AsyncErrorのはず
      asyncValue = agent
          .mockContainer(
            overrides: [
              // 常にエラーを返すHTTPクライアントを使う
              httpClientProvider.overrideWithValue(mockHttpClientError),
            ],
          )
          .listen(
            readmeContentProviderFamily(repo),
            (previous, next) {},
          )
          .read();
      expect(asyncValue is AsyncError, true);
    });
  });
  group('ReadmeMarkdown', () {
    testWidgets('画像取得時にエラーが起きたときはSVGとして取得を試みるはず', (tester) async {
      // 参考サイト: https://github.com/dnfield/flutter_svg/blob/master/test/widget_svg_test.dart

      final repo = GitHubRepoRepository.repoBuilder(
        RepoJsonObject.fromJson(
          TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
        ),
      );

      await fakeSvg(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: SingleChildScrollView(
              child: ReadmeMarkdown(
                repo: repo,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // SvgPictureがあるはず
        expect(find.byType(SvgPicture), findsOneWidget);
      });
    });
    testWidgets('必要なWidgetが表示されるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: SingleChildScrollView(
            child: ReadmeMarkdown(repo: repo),
          ),
        ),
      );
      await tester.pump();

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
        agent.mockApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: SingleChildScrollView(
            child: ReadmeMarkdown(repo: repo),
          ),
        ),
      );
      await tester.pump();

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

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      final repo = GitHubRepoRepository.repoBuilder(
        RepoJsonObject.fromJson(
          TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
        ),
      );
      await tester.pumpWidget(
        agent.mockApp(
          home: SingleChildScrollView(
            child: ReadmeMarkdown(repo: repo),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      // リンクをタップする
      await tester.tap(find.text('リンク'));
      await tester.pump();

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        true,
      );
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await fakeSvg(() async {
        await tester.runAsync(() async {
          testLogger.i('Start pumpDeviceBuilder');
          await tester.pumpDeviceBuilder(
            DeviceBuilder()
              ..addScenario(
                widget: SingleChildScrollView(
                  child: ReadmeMarkdown(repo: repo),
                ),
              ),
            wrapper: (child) => agent.mockApp(
              overrides: [
                readmeMarkdownCacheManagerProvider
                    .overrideWithValue(MockCacheManagerSmall()),
              ],
              home: Material(
                child: child,
              ),
            ),
          );
          await tester.pump();
          testLogger.i('End pump');
        });
        testLogger.i('Start screenMatchesGolden');
        await screenMatchesGolden(tester, 'readme_markdown');
        testLogger.i('End screenMatchesGolden');
      });
    });
  });
}
