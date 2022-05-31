// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/components/search_text_button.dart';
import 'package:github_search/presentation/repo/components/search_text_field.dart';
import 'package:github_search/presentation/repo/pages/search_page.dart';
import 'package:github_search/presentation/repo/state/search_repos_query.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late MockGoRouter mockGoRouter;
  setUp(() {
    mockGoRouter = MockGoRouter();
    useEnvironmentLocale();
  });

  group('RepoSearchTextButton', () {
    testWidgets('prefixIconが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: RepoSearchTextButton(),
          ),
        ),
      );

      // prefixIconが表示されるはず
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
    testWidgets('タップするとリポジトリ検索画面に遷移するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const Scaffold(
              body: RepoSearchTextButton(),
            ),
          ),
        ),
      );

      verifyNever(() => mockGoRouter.goNamed(RepoSearchPage.name));

      // タップするとリポジトリ検索画面に遷移するはず
      await tester.tap(find.byType(RepoSearchTextButton));
      verify(() => mockGoRouter.goNamed(RepoSearchPage.name)).called(1);
    });
    testWidgets('削除ボタンをタップすると検索文字列をクリアしてリポジトリ検索画面に遷移するはず', (tester) async {
      const initQuery = 'foooooo';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 検索文字列を設定する
            repoSearchReposInitQueryStringProvider.overrideWithValue(initQuery),
          ],
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const Scaffold(
              body: RepoSearchTextButton(),
            ),
          ),
        ),
      );

      verifyNever(() => mockGoRouter.goNamed(RepoSearchPage.name));

      // 検索文字列が初期値になっているはず
      final state = tester.state(find.byType(RepoSearchTextField))
          as RepoSearchTextFieldState;
      expect(state.controller.text, initQuery);

      // 削除ボタンをタップする
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));

      // 検索文字列をクリアするはず
      expect(state.controller.text, '');

      // リポジトリ検索画面に遷移するはず
      verify(() => mockGoRouter.goNamed(RepoSearchPage.name)).called(1);
    });
  });
}
