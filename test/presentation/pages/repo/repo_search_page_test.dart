// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history.dart';
import 'package:github_search/domain/repositories/query_history/query_history_repository.dart';
import 'package:github_search/presentation/pages/repo/components/query_histories.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_sort.dart';
import 'package:github_search/presentation/pages/repo/repo_search_page.dart';
import 'package:github_search/utils/localizations/strings.g.dart';

import '../../../test_utils/golden_testing_tools.dart';
import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoSearchPage', () {
    testWidgets('ソートボタン押下でボトムシートが表示されるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: const RepoSearchPage(),
          ),
        );
        await tester.pump();

        expect(find.byType(SearchReposQueryTextField), findsOneWidget);
        expect(find.byType(SearchReposSortButton), findsOneWidget);
        expect(find.byType(SliverQueryHistoriesListView), findsOneWidget);

        // RepoSearchTextに自動でフォーカスが当たるはず
        final state = tester.firstState(find.byType(SearchReposQueryTextField))
            as SearchReposQueryTextFieldState;
        expect(state.focusNode.hasFocus, true);

        // ソートボタンをタップ
        await tester.tap(find.byType(SearchReposSortButton));
        await tester.pumpAndSettle();

        // ソート選択ボトムシートが表示したはず
        expect(find.byType(SearchReposSortSelectorBottomSheet), findsOneWidget);

        // stars をタップ
        await tester.tap(find.text(i18n.starsCount));
        await tester.pumpAndSettle();

        // ソート選択が閉じたはず
        expect(find.byType(SearchReposSortSelectorBottomSheet), findsNothing);
      });
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.runAsync(() async {
        // 検索履歴を追加する
        final repository =
            agent.mockContainer().read(queryHistoryRepositoryProvider);
        for (var i = 0; i < 30; i++) {
          await repository.add(
            QueryHistory.create(
              'flutterflutterflutterflutterflutter$i',
            ),
          );
        }

        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: const RepoSearchPage(),
            ),
          wrapper: (child) => agent.mockApp(
            home: Material(
              child: child,
            ),
          ),
        );

        await Future<void>.delayed(const Duration(seconds: 1));
        await tester.pump();
      });
      await screenMatchesGolden(
        tester,
        'repo_search_page',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
