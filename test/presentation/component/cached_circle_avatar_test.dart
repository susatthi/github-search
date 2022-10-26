// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/component/cached_circle_avatar.dart';

import '../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);
  group('cachedCircleAvatarCacheManagerProvider', () {
    test('初期値はnullのはず', () async {
      final container = ProviderContainer();
      final cacheManager =
          container.read(cachedCircleAvatarCacheManagerProvider);
      expect(cacheManager, isNull);
    });
    testWidgets('nullだとデフォルトのCacheManagerが使われるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            overrides: [
              cachedCircleAvatarCacheManagerProvider.overrideWithValue(null),
            ],
            home: CachedCircleAvatar(
              url: _generateRandomUrl(),
            ),
          ),
        );
        await tester.pump();

        final cachedNetworkImage =
            tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));
        final cacheManager = cachedNetworkImage.cacheManager as CacheManager?;
        expect(cacheManager?.store.storeKey, 'CachedCircleAvatarKey');
      });
    });
  });
  group('CachedCircleAvatar', () {
    testWidgets('ダミー画像が表示されるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: CachedCircleAvatar(
              url: _generateRandomUrl(),
            ),
          ),
        );
        await tester.pump();

        final state = tester
            .state<CachedCircleAvatarState>(find.byType(CachedCircleAvatar));

        // CachedCircleAvatarが表示出来ているはず
        expect(find.byType(CachedCircleAvatar), findsOneWidget);

        // ローディングが表示しているはず
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // 画像は表示されていないはず
        expect(find.byKey(state.circleAvatarKey), findsNothing);

        // 画像が読み込まれるまで待つ
        await Future.doWhile(() async {
          await Future<void>.delayed(Duration.zero);
          await tester.pump();
          return state.error == null && state.imageProvider == null;
        });

        // 画像が表示されているはず
        expect(find.byKey(state.circleAvatarKey), findsOneWidget);
      });
    });
    testWidgets('エラーが表示されるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: const CachedCircleAvatar(
              // URLを空にすると例外が投げられる
              url: '',
            ),
          ),
        );
        await tester.pump();

        final state = tester
            .state<CachedCircleAvatarState>(find.byType(CachedCircleAvatar));

        // エラーは表示されていないはず
        expect(find.byIcon(Icons.error), findsNothing);

        // エラーになるまで待つ
        await Future.doWhile(() async {
          await Future<void>.delayed(Duration.zero);
          await tester.pump();
          return state.error == null && state.imageProvider == null;
        });

        // エラーが表示されているはず
        expect(find.byIcon(Icons.error), findsOneWidget);
      });
    });
    testWidgets('loading=trueでローディングが表示されるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: CachedCircleAvatar(
              url: _generateRandomUrl(),
            ),
          ),
        );
        await tester.pump();

        // ローディングが表示されるはず
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
    testWidgets('loading=falseでローディングが表示されないはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: CachedCircleAvatar(
              url: _generateRandomUrl(),
              loading: false,
            ),
          ),
        );
        await tester.pump();

        // ローディングが表示されないはず
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });
  });
}

String _generateRandomUrl() {
  final name = Random().nextInt(pow(2, 32) as int);
  return 'https://dummy.com/?name=$name';
}
