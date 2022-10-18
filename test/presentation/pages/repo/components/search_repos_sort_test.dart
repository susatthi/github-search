// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_sort.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_order.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_sort.dart';
import 'package:github_search/utils/localizations/strings.g.dart';

import '../../../../test_utils/logger.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';

class _MockPage extends StatelessWidget {
  const _MockPage();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) => const SearchReposSortSelectorBottomSheet(),
      ),
      child: const Text('button'),
    );
  }
}

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('searchReposSortProvider', () {
    test('初期値はベストマッチのはず', () async {
      final sort = agent.mockContainer().read(searchReposSortProvider);
      expect(sort, SearchReposSort.bestMatch);
    });
  });
  group('searchReposSortUpdater', () {
    test('ソート値を変更できるはず', () async {
      final controller =
          agent.mockContainer().read(searchReposSortProvider.notifier);

      // スター数に変更する
      controller.set(SearchReposSort.stars);

      // 値が反映されるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // スター数のはず
      expect(
        agent.mockContainer().read(searchReposSortProvider),
        SearchReposSort.stars,
      );

      // フォーク数に変更する
      controller.set(SearchReposSort.forks);

      // 値が反映されるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // フォーク数のはず
      expect(
        agent.mockContainer().read(searchReposSortProvider),
        SearchReposSort.forks,
      );

      // ヘルプ数に変更する
      controller.set(SearchReposSort.helpWantedIssues);

      // 値が反映されるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // ヘルプ数のはず
      expect(
        agent.mockContainer().read(searchReposSortProvider),
        SearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      controller.set(SearchReposSort.bestMatch);

      // 値が反映されるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // ベストマッチのはず
      expect(
        agent.mockContainer().read(searchReposSortProvider),
        SearchReposSort.bestMatch,
      );
    });
  });
  group('SearchReposSortSelectorBottomSheet', () {
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
        await tester.tap(find.byType(SearchReposOrderToggleButton));
      });
      await tester.pumpAndSettle();

      // 閉じてしまうので再度ボタンをタップする
      testLogger.i('Tap a button 2');
      await tester.tap(find.text('button'));
      await tester.pumpAndSettle();

      // 昇順になったはず
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);

      // もう一度オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 2');
        await tester.tap(find.byType(SearchReposOrderToggleButton));
      });
      await tester.pumpAndSettle();

      // 閉じてしまうので再度ボタンをタップする
      testLogger.i('Tap a button 3');
      await tester.tap(find.text('button'));
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
      await tester.tap(find.byType(SearchReposOrderToggleButton));

      // オーダー変更ボタンは昇順のままのはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsNothing);
    });
  });
  group('RepoSortButton', () {
    testWidgets('正しく表示できるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposSortButton(),
          ),
        ),
      );
      await tester.pump();

      // tooltipが正しいはず
      final button = tester.widget(find.byType(IconButton)) as IconButton;
      expect(button.tooltip, i18n.sort);

      // アイコンが正しいはず
      final icon = button.icon as Icon;
      expect(icon.icon, Icons.sort);
    });

    testWidgets('ボタン押下でボトムシートを表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposSortButton(),
          ),
        ),
      );
      await tester.pump();

      // まだ表示されていないはず
      expect(find.byType(SearchReposSortSelectorBottomSheet), findsNothing);

      // ボタンをタップ
      await tester.tap(find.byType(SearchReposSortButton));
      await tester.pumpAndSettle();

      // 表示したはず
      expect(find.byType(SearchReposSortSelectorBottomSheet), findsOneWidget);

      // 適当なところをタップ
      await tester.tapAt(const Offset(100, 100));
      await tester.pumpAndSettle();

      // 消えたはず
      expect(find.byType(SearchReposSortSelectorBottomSheet), findsNothing);
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
