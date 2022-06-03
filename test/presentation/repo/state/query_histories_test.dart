// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/query_history_input.dart';
import 'package:github_search/domain/repositories/query_history_repository.dart';
import 'package:github_search/presentation/repo/state/query_histories.dart';
import 'package:github_search/presentation/repo/state/search_repos_query.dart';

import '../../../test_utils/test_agent.dart';

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
        agent
            .mockContainer()
            .read(repoSearchReposEnteringQueryStringUpdater)('')
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
  });
}
