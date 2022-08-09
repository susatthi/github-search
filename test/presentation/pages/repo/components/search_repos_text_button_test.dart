// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/router.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_text_button.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('SearchReposTextButton', () {
    testWidgets('prefixIconが表示されるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: SearchReposTextButton(),
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
              body: SearchReposTextButton(),
            ),
          ),
        ),
      );
      await tester.pump();

      final location = const RepoSearchRoute().location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // タップするとリポジトリ検索画面に遷移するはず
      await tester.tap(find.byType(SearchReposTextButton));
      expect(agent.mockGoRouter.calledLocations.contains(location), true);
    });
    testWidgets('削除ボタンをタップすると検索文字列をクリアしてリポジトリ検索画面に遷移するはず', (tester) async {
      const initQuery = 'foooooo';
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を設定する
            searchReposInitQueryStringProvider.overrideWithValue(initQuery),
          ],
          home: InheritedGoRouter(
            goRouter: agent.mockGoRouter,
            child: const Scaffold(
              body: SearchReposTextButton(),
            ),
          ),
        ),
      );
      await tester.pump();

      final location = const RepoSearchRoute().location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // 検索文字列が初期値になっているはず
      final state = tester.state(find.byType(SearchReposTextField))
          as SearchReposTextFieldState;
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
