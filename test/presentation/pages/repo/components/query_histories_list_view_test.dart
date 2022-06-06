// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history_input.dart';
import 'package:github_search/domain/repositories/query_history/query_history_repository.dart';
import 'package:github_search/presentation/pages/repo/components/query_histories_list_view.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';

import '../../../../test_utils/logger.dart';
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
                  ref.read(searchReposQueryStringUpdater)('flutter');
                },
                icon: const Icon(Icons.add),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: TextField(
                  onChanged: (text) {
                    ref.read(searchReposEnteringQueryStringUpdater)(text);
                  },
                ),
              ),
            ],
          ),
          const SliverQueryHistoriesListView(),
        ],
      ),
    );
  }
}

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('QueryHistoriesNotifier', () {
    test('Notifierを生成すると検索履歴一覧を取得するはず', () async {
      final notifier = agent
          .mockContainer()
          .listen(
            queryHistoriesProvider.notifier,
            (previous, next) {},
          )
          .read();

      // 初期値はAsyncLoading
      expect(notifier.state is AsyncLoading, true);

      // 検索履歴一覧を取り終わるまで待つ
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // 検索履歴一覧が取得できているはず
      expect(notifier.state is AsyncData, true);
    });
    test('検索履歴を削除できるはず', () async {
      final repository =
          agent.mockContainer().read(queryHistoryRepositoryProvider);
      await Future.wait(
        [repository.add(QueryHistoryInput(queryString: 'flutter'))],
      );

      // 入力中の検索文字列を更新して検索履歴一覧を更新する
      await Future.wait([
        agent.mockContainer().read(searchReposEnteringQueryStringUpdater)('')
      ]);

      final notifier = agent
          .mockContainer()
          .listen(
            queryHistoriesProvider.notifier,
            (previous, next) {},
          )
          .read();

      // 検索履歴一覧を取り終わるまで待つ
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // 検索履歴が1件取得できているはず
      expect(notifier.state is AsyncData, true);
      expect(notifier.state.value!.length, 1);

      // 検索履歴を削除する
      final query = notifier.state.value!.first;
      await Future.wait([notifier.delete(query)]);

      // 検索履歴が削除されているはず
      expect(notifier.state is AsyncData, true);
      expect(notifier.state.value!.length, 0);
    });
    test('Notifierを連続で生成してDisposeされても問題ないはず', () async {
      QueryHistoriesNotifier? currentNotifier;
      final container = agent.mockContainer(
        overrides: [
          // 検索文字列の初期値は空文字にしておく
          searchReposInitQueryStringProvider.overrideWithValue(''),
        ],
      )..listen<QueryHistoriesNotifier>(
          queryHistoriesProvider.notifier,
          (previous, next) {
            testLogger.i(next);
            currentNotifier = next;
          },
        );

      expect(currentNotifier, isNull);

      // fを入力
      await container.read(searchReposEnteringQueryStringUpdater)('f');

      // Notifierが更新されるまで待つ
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(currentNotifier?.queryString, 'f');

      // flを入力
      await container.read(searchReposEnteringQueryStringUpdater)('fl');

      // Notifierが更新されるまで待つ
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(currentNotifier?.queryString, 'fl');
    });
  });
  group('SliverQueryHistoriesListView', () {
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
