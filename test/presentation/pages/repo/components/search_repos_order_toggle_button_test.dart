// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_order.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_order_toggle_button.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';

import '../../../../test_utils/logger.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('searchReposOrderProvider', () {
    test('初期値は降順のはず', () async {
      final order = agent.mockContainer().read(searchReposOrderProvider);
      expect(order, SearchReposOrder.desc);
    });
  });
  group('searchReposOrderUpdater', () {
    test('オーダー値を変更できるはず', () async {
      final updater = agent.mockContainer().read(searchReposOrderUpdater);

      // 昇順に変更する
      updater(SearchReposOrder.asc);

      // 昇順のはず
      expect(
        agent.mockContainer().read(searchReposOrderProvider),
        SearchReposOrder.asc,
      );

      // 降順に変更する
      updater(SearchReposOrder.desc);

      // 降順のはず
      expect(
        agent.mockContainer().read(searchReposOrderProvider),
        SearchReposOrder.desc,
      );
    });
  });
  group('SearchReposOrderToggleButton', () {
    testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposOrderToggleButton(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 最初は降順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);

      // オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 1');
        await tester.tap(find.byType(SearchReposOrderToggleButton));
      });
      await tester.pump();

      // 昇順になったはず
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      await tester.pump();

      // もう一度オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 2');
        await tester.tap(find.byType(SearchReposOrderToggleButton));
      });
      await tester.pump();

      // 降順になったはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });
    testWidgets('ローディング中は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposOrderToggleButton(),
          ),
        ),
      );
      await tester.pump();

      // ローディング中は無効化になるはず
      expect(find.byType(SearchReposOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<SearchReposOrderToggleButtonInternal>(
              find.byType(SearchReposOrderToggleButtonInternal),
            )
            .first
            .enabled,
        false,
      );

      await tester.pump();

      // ローディングが終了したら有効化になるはず
      expect(find.byType(SearchReposOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<SearchReposOrderToggleButtonInternal>(
              find.byType(SearchReposOrderToggleButtonInternal),
            )
            .first
            .enabled,
        true,
      );
    });
    testWidgets('エラー時は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: const Scaffold(
            body: SearchReposOrderToggleButton(),
          ),
        ),
      );
      await tester.pump();

      // エラー時は無効化になるはず
      expect(find.byType(SearchReposOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<SearchReposOrderToggleButtonInternal>(
              find.byType(SearchReposOrderToggleButtonInternal),
            )
            .first
            .enabled,
        false,
      );
    });
    testWidgets('初期化中は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を空文字にする
            searchReposInitQueryStringProvider.overrideWithValue(''),
          ],
          home: const Scaffold(
            body: SearchReposOrderToggleButton(),
          ),
        ),
      );
      await tester.pump();

      // 初期状態は無効化になるはず
      expect(find.byType(SearchReposOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<SearchReposOrderToggleButtonInternal>(
              find.byType(SearchReposOrderToggleButtonInternal),
            )
            .first
            .enabled,
        false,
      );

      await tester.pump();

      // 有効化になるはず
      expect(find.byType(SearchReposOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<SearchReposOrderToggleButtonInternal>(
              find.byType(SearchReposOrderToggleButtonInternal),
            )
            .first
            .enabled,
        true,
      );
    });
  });
}
