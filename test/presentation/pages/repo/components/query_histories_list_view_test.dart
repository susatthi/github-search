// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/query_history_repository.dart';
import 'package:github_search/presentation/pages/repo/components/query_histories_list_view.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';

import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';

class _MockPage extends ConsumerWidget {
  const _MockPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(repoSearchReposQueryStringUpdater)('flutter');
                },
                icon: const Icon(Icons.add),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: TextField(
                  onChanged: (text) {
                    ref.read(repoSearchReposEnteringQueryStringUpdater)(text);
                  },
                ),
              ),
            ],
          ),
          const SliverRepoQueryHistoriesListView(),
        ],
      ),
    );
  }
}

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('SliverRepoQueryHistoriesListView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: const _MockPage(),
          ),
        );

        // 何も表示していないはず
        expect(find.byType(SliverFillRemaining), findsOneWidget);
        final remaining = tester.widget(find.byType(SliverFillRemaining))
            as SliverFillRemaining;
        expect(remaining.child, isNull);

        await tester.pump();

        // 何も表示していないはず
        expect(find.byType(SliverFillRemaining), findsOneWidget);
        final remaining2 = tester.widget(find.byType(SliverFillRemaining))
            as SliverFillRemaining;
        expect(remaining2.child, isNull);
      });
    });
    testWidgets('エラーが発生した場合は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 常にエラーを発生させる
            queryHistoryRepositoryProvider
                .overrideWithValue(MockQueryHistoryRepositoryError()),
          ],
          home: const _MockPage(),
        ),
      );

      // 何も表示していないはず
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      final remaining = tester.widget(find.byType(SliverFillRemaining))
          as SliverFillRemaining;
      expect(remaining.child, isNull);

      await tester.pump();

      // 何も表示していないはず
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      final remaining2 = tester.widget(find.byType(SliverFillRemaining))
          as SliverFillRemaining;
      expect(remaining2.child, isNull);
    });
    testWidgets('検索履歴をサジェストして削除ができるはず', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          agent.mockApp(
            home: const _MockPage(),
          ),
        );
        await tester.pumpAndSettle();

        // 検索履歴を登録する
        await tester.tap(find.byType(IconButton));
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await tester.pump();

        // 検索文字列を入力する
        await tester.enterText(find.byType(TextField), 'flu');
        await tester.pump();
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await tester.pump();

        // 検索履歴を1件サジェストするはず
        expect(find.byType(SliverList), findsOneWidget);
        expect(find.byType(ListTile), findsOneWidget);

        // サジェストの削除ボタン押下
        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();
        await Future<void>.delayed(const Duration(milliseconds: 500));
        await tester.pump();

        // 検索履歴が0件になるはず
        expect(find.byType(SliverList), findsNothing);
      });
    });
  });
}
