// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/query_history.dart';
import '../state/query_histories.dart';
import '../state/search_repos_query.dart';

/// Sliver版検索履歴一覧View
class SliverRepoQueryHistoriesListView extends ConsumerWidget {
  const SliverRepoQueryHistoriesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(queryHistoriesProvider);
    return asyncValue.when(
      data: (queryHistories) => SliverRepoQueryHistoriesListViewInternal(
        queryHistories: queryHistories,
      ),
      error: (_, __) => const SliverFillRemaining(),
      loading: () => const SliverFillRemaining(),
    );
  }
}

@visibleForTesting
class SliverRepoQueryHistoriesListViewInternal extends StatelessWidget {
  const SliverRepoQueryHistoriesListViewInternal({
    super.key,
    required this.queryHistories,
  });

  /// サジェストする検索履歴のリスト
  final List<QueryHistory> queryHistories;

  @override
  Widget build(BuildContext context) {
    if (queryHistories.isEmpty) {
      return const SliverFillRemaining();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _QueryHistoryListTile(
          query: queryHistories[index],
        ),
        childCount: queryHistories.length,
      ),
    );
  }
}

/// サジェストする検索履歴ListTile
class _QueryHistoryListTile extends ConsumerWidget {
  const _QueryHistoryListTile({
    required this.query,
  });

  /// 検索履歴
  final QueryHistory query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(query.queryString),
      trailing: IconButton(
        onPressed: () {
          ref.read(queryHistoriesProvider.notifier).delete(query);
        },
        icon: const Icon(Icons.close),
      ),
      onTap: () {
        ref.read(repoSearchReposQueryStringUpdater)(query.queryString);
        Navigator.of(context).pop();
      },
    );
  }
}
