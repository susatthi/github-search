// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';
import 'package:github_search/utils/env/env.dart';
import 'package:github_search/utils/routing/router.dart';
import 'package:go_router/go_router.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('searchReposInitQueryProvider', () {
    test('初期値は環境変数の値と一致するはず', () async {
      final query = ProviderContainer().read(searchReposInitQueryProvider);
      expect(query, Env.defaultSearchValue);
    });
  });
  group('searchReposQueryStringUpdater', () {
    test('検索文字列を変更できるはず', () async {
      // 検索文字列を変更する
      await agent
          .mockContainer()
          .read(searchReposQueryProvider.notifier)
          .enter('dummy');
      final query = agent.mockContainer().read(searchReposQueryProvider);
      expect(query, 'dummy');
    });
  });
  group('searchReposEnteringQueryStringUpdater', () {
    test('入力中の検索文字列を変更できるはず', () async {
      // 入力中の検索文字列を変更する
      await agent
          .mockContainer()
          .read(searchReposEnteringQueryProvider.notifier)
          .enter('dummy');
      final query =
          agent.mockContainer().read(searchReposEnteringQueryProvider);
      expect(query, 'dummy');
    });
  });
  group('SearchReposTextField', () {
    testWidgets('検索を実行すると検索文字列を更新するはず', (tester) async {
      const expectedQuery = 'foooooo';
      final controller = TextEditingController();
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryProvider.overrideWithValue(expectedQuery),
          ],
          home: Scaffold(
            body: SearchReposQueryTextField(
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pump();

      // 最初は入力中の検索文字列を表示するはず
      expect(controller.text, expectedQuery);

      // 最初は全選択状態のはず
      expect(controller.selection.baseOffset, 0);
      expect(controller.selection.extentOffset, expectedQuery.length);

      // 検索文字列を入力してキーボードのDone押下
      await tester.runAsync(() async {
        await tester.enterText(find.byType(TextField), 'kboy');
        await tester.testTextInput.receiveAction(TextInputAction.done);
      });

      // 検索文字列が変わっているはず
      expect(controller.text, 'kboy');
    });
    testWidgets('別で検索文字列が更新されたら同期するはず', (tester) async {
      const expectedQuery = 'foooooo';
      final controller1 = TextEditingController();
      final controller2 = TextEditingController();
      final key1 = GlobalKey();
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryProvider.overrideWithValue(expectedQuery),
          ],
          home: Scaffold(
            body: Column(
              children: [
                SearchReposQueryTextField(
                  key: key1,
                  controller: controller1,
                ),
                SearchReposQueryTextField(
                  controller: controller2,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      // 最初は入力中の検索文字列を表示するはず
      expect(controller1.text, expectedQuery);
      expect(controller2.text, expectedQuery);

      // 1番目のTextFieldに検索文字列を入力してキーボードのDone押下
      await tester.runAsync(() async {
        await tester.enterText(find.byKey(key1), 'kboy');
        await tester.testTextInput.receiveAction(TextInputAction.done);
      });

      // 両方とも検索文字列が変わっているはず
      expect(controller1.text, 'kboy');
      expect(controller2.text, 'kboy');
    });
    testWidgets('検索文字列の有無によって削除ボタンの表示非表示が切り替わるはず', (tester) async {
      var tappedDeleteButton = false;
      final controller = TextEditingController();
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryProvider.overrideWithValue('some query'),
          ],
          home: Scaffold(
            body: SearchReposQueryTextField(
              controller: controller,
              onTappedDelete: () {
                tappedDeleteButton = true;
              },
            ),
          ),
        ),
      );
      await tester.pump();

      // 検索文字列があるので削除ボタンが表示されているので押せるはず
      expect(tappedDeleteButton, false);
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(tappedDeleteButton, true);

      tappedDeleteButton = false;

      // 検索文字列は消されているはず
      expect(controller.text, '');

      // 削除ボタンを押そうとするけど押せないはず
      expect(find.byIcon(Icons.close), findsNothing);
      expect(tappedDeleteButton, false);

      // 任意の文字列を入力する
      await tester.enterText(find.byType(TextField), 'kboy');
      await tester.pump();

      // 検索文字列があるので削除ボタンが表示されているので押せるはず
      expect(tappedDeleteButton, false);
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      expect(tappedDeleteButton, true);
    });
    testWidgets('readOnlyをtrueにすると読み取り専用になるはず', (tester) async {
      var tapped = false;
      var tappedDeleteButton = false;
      final controller = TextEditingController();
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryProvider.overrideWithValue('some query'),
          ],
          home: Scaffold(
            body: SearchReposQueryTextField(
              readOnly: true,
              controller: controller,
              onTap: () {
                tapped = true;
              },
              onTappedDelete: () {
                tappedDeleteButton = true;
              },
            ),
          ),
        ),
      );
      await tester.pump();

      // 任意の文字列を入力しても読み取り専用なので変更できないはず
      await tester.enterText(find.byType(TextField), 'kboy');
      await tester.pump();
      expect(controller.text, 'some query');

      // 読み取り専用でもTextFieldをタップは反応するはず
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(tapped, true);

      // 読み取り専用でも削除ボタン押下は反応して削除できるはず
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      expect(tappedDeleteButton, true);
      expect(controller.text, '');
    });
    testWidgets('prefixIconを設定できるはず', (tester) async {
      const expectedIcon = Icons.search;
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposQueryTextField(
              prefixIcon: Icon(expectedIcon),
            ),
          ),
        ),
      );
      await tester.pump();

      // prefixIconを設定できるはず
      expect(find.byIcon(expectedIcon), findsOneWidget);
    });
  });
  group('SearchReposTextButton', () {
    testWidgets('prefixIconが表示されるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposQueryTextButton(),
          ),
        ),
      );
      await tester.pump();

      // prefixIconが表示されるはず
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
    testWidgets('タップするとリポジトリ検索画面に遷移するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: InheritedGoRouter(
            goRouter: agent.mockGoRouter,
            child: const Scaffold(
              body: SearchReposQueryTextButton(),
            ),
          ),
        ),
      );
      await tester.pump();

      final location = const RepoSearchRoute().location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // タップするとリポジトリ検索画面に遷移するはず
      await tester.tap(find.byType(SearchReposQueryTextButton));
      expect(agent.mockGoRouter.calledLocations.contains(location), true);
    });
    testWidgets('削除ボタンをタップすると検索文字列をクリアしてリポジトリ検索画面に遷移するはず', (tester) async {
      const initQuery = 'foooooo';
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryProvider.overrideWithValue(initQuery),
          ],
          home: InheritedGoRouter(
            goRouter: agent.mockGoRouter,
            child: const Scaffold(
              body: SearchReposQueryTextButton(),
            ),
          ),
        ),
      );
      await tester.pump();

      final location = const RepoSearchRoute().location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // 検索文字列が初期値になっているはず
      final state = tester.state(find.byType(SearchReposQueryTextField))
          as SearchReposQueryTextFieldState;
      expect(state.controller.text, initQuery);

      // 削除ボタンをタップする
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));

      // 検索文字列をクリアするはず
      expect(state.controller.text, '');

      // リポジトリ検索画面に遷移するはず
      expect(agent.mockGoRouter.calledLocations.contains(location), true);
    });
  });
}
