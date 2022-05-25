// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/components/search_text_button.dart';
import 'package:github_search/presentation/repo/pages/search_page.dart';
import 'package:github_search/presentation/repo/state/search_repos_query.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/logger.dart';
import '../../../test_utils/mocks.dart';

String? _query;

class _MockRepoSearchReposQueryNotifier extends RepoSearchReposQueryNotifier {
  _MockRepoSearchReposQueryNotifier(
    String query,
  ) : super(query) {
    _query = query;
  }

  @override
  set query(String query) {
    _query = query;
  }
}

void main() {
  late MockGoRouter mockGoRouter;
  setUp(() {
    mockGoRouter = MockGoRouter();
    _query = null;
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

      expect(_query, isNull);

      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 検索文字列を設定する
            repoSearchReposInitQueryProvider.overrideWithValue(initQuery),
            // Mock版に差し替える
            repoSearchReposQueryProvider.overrideWithProvider(
              StateNotifierProvider<RepoSearchReposQueryNotifier, String>(
                (ref) {
                  final query = ref.watch(repoSearchReposInitQueryProvider);
                  testLogger.i(query);
                  return _MockRepoSearchReposQueryNotifier(query);
                },
              ),
            )
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
      expect(_query, initQuery);

      // 削除ボタンをタップする
      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));

      // 検索文字列をクリアするはず
      expect(_query, '');

      // リポジトリ検索画面に遷移するはず
      verify(() => mockGoRouter.goNamed(RepoSearchPage.name)).called(1);
    });
  });
}
