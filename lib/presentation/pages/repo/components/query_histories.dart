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
final queryHistoriesProvider = StateNotifierProvider.autoDispose<
    QueryHistoriesController, AsyncValue<List<QueryHistory>>>(
  (ref) => QueryHistoriesController(
    queryHistoryRepository: ref.watch(queryHistoryRepositoryProvider),
    queryString: ref.watch(searchReposEnteringQueryProvider),
  ),
  name: 'queryHistoriesProvider',
);

/// 検索履歴一覧コントローラー
class QueryHistoriesController
    extends StateNotifier<AsyncValue<List<QueryHistory>>> {
  QueryHistoriesController({
    required this.queryHistoryRepository,
    required this.queryString,
  }) : super(const AsyncValue.loading()) {
    _load();
  }

  final QueryHistoryRepository queryHistoryRepository;

  /// 検索文字列
  final String queryString;

  Future<void> _load() async {
    final asyncValue = await AsyncValue.guard(() async {
      return queryHistoryRepository.finds(queryString: queryString);
    });
    if (mounted) {
      // 検索文字列を高速で入力されると、検索履歴を検索中に本Notifierが破棄されること
      // があるので、破棄されていないかをチェックする必要がある
      state = asyncValue;
      if (asyncValue is AsyncData) {
        logger.v('Updated state: queries.length = ${asyncValue.value!.length}');
      } else if (asyncValue is AsyncError) {
        logger.v(
          'Updated state: asyncError = ${asyncValue.asError?.error.toString()}',
        );
      }
    } else {
      logger.v(
        'Unmounted state: asyncValue = $asyncValue',
      );
    }
  }

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory queryHistory) async {
    state = const AsyncValue.loading();
    await queryHistoryRepository.delete(queryHistory);
    await _load();
  }

  @override
  String toString() => '{queryString: $queryString, hashCode: $hashCode}';
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
        onPressed: () {
          ref.read(queryHistoriesProvider.notifier).delete(queryHistory);
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
