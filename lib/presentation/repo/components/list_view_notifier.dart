// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repo/entities/repo_data.dart';
import '../../../domain/repo/repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'list_view_state.dart';
import 'search_repos_order.dart';
import 'search_repos_query.dart';
import 'search_repos_sort.dart';

/// リポジトリ一覧View状態プロバイダー
final repoListViewStateProvider = StateNotifierProvider.autoDispose<
    RepoListViewNotifier, AsyncValue<RepoListViewState>?>(
  (ref) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    final query = ref.watch(repoSearchReposQueryProvider);
    final sort = ref.watch(repoSearchReposSortProvider);
    final order = ref.watch(repoSearchReposOrderProvider);
    logger.i(
      'Create RepoListViewNotifier: query=$query, '
      'sort=${sort.name}, order=${order.name}',
    );
    return RepoListViewNotifier(
      repoRepository,
      query: query,
      sort: sort,
      order: order,
    );
  },
);

/// リポジトリ一覧ViewNotifier
class RepoListViewNotifier
    extends StateNotifier<AsyncValue<RepoListViewState>?> {
  RepoListViewNotifier(
    this._repoRepository, {
    required this.query,
    required this.sort,
    required this.order,
  }) : super(null) {
    _search();
  }

  final RepoRepository _repoRepository;

  /// 検索文字列
  final String query;

  /// 検索ソート
  final RepoSearchReposSort sort;

  /// 検索オーダー
  final RepoSearchReposOrder order;

  /// 1ページに取得するレポジトリの数
  static const perPage = 30;

  Future<void> _search() async {
    state = await AsyncValue.guard(() async {
      final trimQuery = query.trim();
      if (trimQuery.isEmpty) {
        return const RepoListViewState();
      }

      state = const AsyncValue.loading();

      final result = await _repoRepository.searchRepos(
        query: trimQuery,
        sort: sort,
        order: order,
        perPage: perPage,
      );
      logger.i(
        'result: totalCount=${result.totalCount}, '
        'items=${result.items.length}, ',
      );
      return RepoListViewState.from(result, trimQuery);
    });
  }

  /// 次のページを取得する
  Future<void> fetchNextPage() async {
    final value = state?.value;
    if (value == null) {
      return;
    }

    // 次のページが無ければ何もしない
    if (!value.hasNext) {
      return;
    }

    // 次のページを取得する
    state = await AsyncValue.guard(() async {
      final result = await _repoRepository.searchRepos(
        query: query,
        sort: sort,
        order: order,
        perPage: perPage,
        page: value.page + 1,
      );

      final appendedItems = result.items.map(RepoData.from).toList();
      logger.i(
        'Result: totalCount=${result.totalCount}, '
        'fetchItems=${result.items.length}, '
        'totalItems=${value.items.length + appendedItems.length}, ',
      );
      return value.copyWith(
        items: value.items + appendedItems,
        hasNext: result.items.length == perPage,
        page: value.page + 1,
      );
    });
  }
}
