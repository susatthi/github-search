// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/logger.dart';
import 'search_repos_query.dart';

/// 検索履歴一覧プロバイダー
final queryHistoriesProvider = FutureProvider.autoDispose<List<QueryHistory>>(
  (ref) {
    final enteringQueryString = ref.watch(searchReposEnteringQueryProvider);
    ref.listen(
      queryHistoriesStreamProviderFamily(enteringQueryString),
      (previous, next) {
        ref.state = next;
      },
    );
    return ref
        .watch(queryHistoriesFutureProviderFamily(enteringQueryString).future);
  },
  name: 'queryHistoriesProvider',
);

// 検索履歴一覧コントローラープロバイダー
final queryHistoriesControllerProvider = Provider<QueryHistoriesController>(
  (ref) => QueryHistoriesController(
    queryHistoryRepository: ref.watch(queryHistoryRepositoryProvider),
  ),
);

/// 検索履歴一覧コントローラー
class QueryHistoriesController {
  QueryHistoriesController({
    required this.queryHistoryRepository,
  });

  final QueryHistoryRepository queryHistoryRepository;

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory queryHistory) async {
    await queryHistoryRepository.delete(queryHistory);
  }
}

/// Sliver版検索履歴一覧View
class SliverQueryHistoriesListView extends ConsumerWidget {
  const SliverQueryHistoriesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(queryHistoriesProvider);
    return asyncValue.when(
      data: (queryHistories) => SliverQueryHistoriesListViewInternal(
        queryHistories: queryHistories,
      ),
      error: (_, __) => const SliverFillRemaining(),
      loading: () => const SliverFillRemaining(),
    );
  }
}

@visibleForTesting
class SliverQueryHistoriesListViewInternal extends StatelessWidget {
  const SliverQueryHistoriesListViewInternal({
    super.key,
    required this.queryHistories,
  });

  /// サジェストする検索履歴のリスト
  final List<QueryHistory> queryHistories;

  @override
  Widget build(BuildContext context) {
    logger.v('queryHistories.length = ${queryHistories.length}');
    if (queryHistories.isEmpty) {
      return const SliverFillRemaining();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _QueryHistoryListTile(
          queryHistory: queryHistories[index],
        ),
        childCount: queryHistories.length,
      ),
    );
  }
}

/// サジェストする検索履歴ListTile
class _QueryHistoryListTile extends ConsumerWidget {
  const _QueryHistoryListTile({
    required this.queryHistory,
  });

  /// 検索履歴
  final QueryHistory queryHistory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(queryHistory.queryString.value),
      trailing: IconButton(
        onPressed: () async {
          await ref.read(queryHistoriesControllerProvider).delete(queryHistory);
        },
        icon: const Icon(Icons.close),
      ),
      onTap: () {
        ref.read(searchReposQueryProvider.notifier).update(
              queryHistory.queryString.value,
            );
        Navigator.of(context).pop();
      },
    );
  }
}
