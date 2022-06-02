// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/repo/components/order_toggle_button.dart';
import 'package:github_search/presentation/repo/components/sort_selector_bottom_sheet.dart';
import 'package:github_search/utils/extensions.dart';

import '../../../test_utils/logger.dart';

import '../../../test_utils/mocks.dart';
import '../../../test_utils/test_agent.dart';

class _MockPage extends StatelessWidget {
  const _MockPage();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) => const RepoSortSelectorBottomSheet(),
      ),
      child: const Text('button'),
    );
  }
}

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoSortSelectorBottomSheet', () {
    testWidgets('各選択肢を選択してソートが変更されるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // ボタンをタップする
      testLogger.i('Tap a button 1');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // 4つの選択肢が表示されているはず
      expect(find.text(i18n.bestMatch), findsOneWidget);
      expect(find.text(i18n.starsCount), findsOneWidget);
      expect(find.text(i18n.forksCount), findsOneWidget);
      expect(find.text(i18n.helpWantedIssuesCount), findsOneWidget);

      // 初期値はベストマッチのはず
      _expectListTile(tester, i18n.bestMatch);

      // スター数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at starsCount');
        await tester.tap(find.text(i18n.starsCount));
      });
      await tester.pumpAndSettle();

      // ボタンをタップする
      testLogger.i('Tap a button 2');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // スター数に変更されているはず
      _expectListTile(tester, i18n.starsCount);

      // フォーク数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at forksCount');
        await tester.tap(find.text(i18n.forksCount));
      });
      await tester.pumpAndSettle();

      // ボタンをタップする
      testLogger.i('Tap a button 3');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // フォーク数に変更されているはず
      _expectListTile(tester, i18n.forksCount);

      // ヘルプ数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at helpWantedIssuesCount');
        await tester.tap(find.text(i18n.helpWantedIssuesCount));
      });
      await tester.pumpAndSettle();

      // ボタンをタップする
      testLogger.i('Tap a button 4');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // ヘルプ数に変更されているはず
      _expectListTile(tester, i18n.helpWantedIssuesCount);
    });
    testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // ボタンをタップする
      testLogger.i('Tap a button 1');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // 最初は降順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);

      // オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 1');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pumpAndSettle();

      // 昇順になったはず
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);

      // もう一度オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 2');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pumpAndSettle();

      // 降順になったはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });
    testWidgets('エラーが発生したらオーダーボタンは押せないはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // ボタンをタップする
      testLogger.i('Tap a button 1');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // オーダー変更ボタンは昇順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsNothing);

      // オーダー変更ボタンが disable になっているので押せないはず
      await tester.tap(find.byType(RepoOrderToggleButton));

      // オーダー変更ボタンは昇順のままのはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsNothing);
    });
  });
}

/// RepoSortSelectorDialog の項目にチェックがついているかどうかを検査する
void _expectListTile(WidgetTester tester, String checkedText) {
  // checkedText をもつ Text が1ついるはず
  expect(find.text(checkedText), findsOneWidget);

  // checkedText をもつ ListTile を1つ取り出す
  final listTile =
      tester.widgetList<ListTile>(find.byType(ListTile)).firstWhereOrNull(
            (listTile) => (listTile.title as Text?)?.data == checkedText,
          );
  expect(listTile, isNotNull);

  // ListTile の leading（Visibility）を取り出せるはず
  final visibility = listTile!.leading as Visibility?;
  expect(visibility, isNotNull);

  // Visibility から Icon を取り出せるはず
  final icon = visibility!.child as Icon?;
  expect(icon, isNotNull);
  expect(icon!.icon, Icons.check);
}
