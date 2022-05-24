// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/cached_circle_avatar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

class MockDefaultCacheManager extends Mock implements DefaultCacheManager {}

void main() {
  const dummyUrl = 'https://keyber.jp/images/logo_white.png';
  late DefaultCacheManager mockCacheManager;
  setUp(() {
    useEnvironmentLocale();
    mockCacheManager = MockDefaultCacheManager();
  });

  group('CachedCircleAvatar', () {
    testWidgets('ダミー画像が表示されるはず', (tester) async {
      // UnitTestでimageBuilderでダミー画像を表示する方法が存在しないようなので
      // テストは未実施です。下記のIssueで報告されているがいまだにOpenのままです。
      //
      // https://github.com/Baseflow/flutter_cache_manager/issues/290
    });
    testWidgets('エラーが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: CachedCircleAvatar(
            cacheManager: mockCacheManager,
            url: dummyUrl,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.error), findsOneWidget);
    });
    testWidgets('loading=trueでローディングが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: CachedCircleAvatar(
            cacheManager: mockCacheManager,
            url: dummyUrl,
          ),
        ),
      );

      // ローディングが表示されるはず
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      // 読み込みが完了したらローディングは表示されないはず
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    testWidgets('loading=falseでローディングが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: CachedCircleAvatar(
            cacheManager: mockCacheManager,
            url: dummyUrl,
            loading: false,
          ),
        ),
      );

      // ローディングが表示されないはず
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.pumpAndSettle();

      // 読み込みが完了してもローディングは表示されないはず
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
