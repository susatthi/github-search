// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/repo/search_repos_service.dart';
import '../../../../application/repo/state/query_histories.dart';
import '../../../../domain/repository/query_history/entity/query_history.dart';
import '../../../../util/logger.dart';

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
          await ref.read(searchReposServiceProvider).delete(queryHistory);
        },
        icon: const Icon(Icons.close),
      ),
      onTap: () async {
        await ref.read(searchReposServiceProvider).select(queryHistory);
        Navigator.of(context).pop();
      },
    );
  }
}
