// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_list_view_state.dart';
import 'repo_search_repos_order.dart';
import 'repo_search_repos_query.dart';
import 'repo_search_repos_sort.dart';

/// リポジトリ一覧View状態プロバイダー
final repoListViewStateProvider = StateNotifierProvider.autoDispose<
    RepoListViewController, AsyncValue<RepoListViewState>>(
  (ref) {
    final reposRepository = ref.watch(repoRepositoryProvider);
    final query = ref.watch(repoSearchReposQueryProvider);
    final sort = ref.watch(repoSearchReposSortProvider);
    final order = ref.watch(repoSearchReposOrderProvider);
    logger.i(
      'create RepoListViewController: query=$query, '
      'sort=${sort.name}, order=${order.name}',
    );
    return RepoListViewController(
      reposRepository,
      query: query,
      sort: sort,
      order: order,
    );
  },
);

/// リポジトリ一覧Viewコントローラー
class RepoListViewController
    extends StateNotifier<AsyncValue<RepoListViewState>> {
  RepoListViewController(
    this._reposRepository, {
    required this.query,
    required this.sort,
    required this.order,
  }) : super(const AsyncValue.loading()) {
    _search();
  }

  final RepoRepository _reposRepository;

  /// 検索文字列
  final String query;

  /// 検索ソート
  final RepoSearchReposSort sort;

  /// 検索オーダー
  final RepoSearchReposOrder order;

  /// 1ページに取得するレポジトリの数
  static const perPage = 30;

  Future<void> _search() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final trimQuery = query.trim();
      if (trimQuery.isEmpty) {
        return const RepoListViewState();
      }

      final result = await _reposRepository.searchRepos(
        query: trimQuery,
        sort: sort,
        order: order,
        perPage: perPage,
      );
      logger.i(
        'result: totalCount=${result.totalCount}, '
        'items=${result.items.length}, ',
      );
      return RepoListViewState.from(result);
    });
  }

  /// 次のページを取得する
  Future<void> fetchNextPage() async {
    final value = state.value;
    if (value == null) {
      return;
    }

    // 次のページが無ければ何もしない
    if (!value.hasNext) {
      return;
    }

    // 次のページを取得する
    state = await AsyncValue.guard(() async {
      final result = await _reposRepository.searchRepos(
        query: query,
        sort: sort,
        order: order,
        perPage: perPage,
        page: value.page + 1,
      );

      value.items.addAll(result.items.map(RepoData.from).toList());
      logger.i(
        'result: totalCount=${result.totalCount}, '
        'fetchItems=${result.items.length}, '
        'totalItems=${value.items.length}, ',
      );
      return value.copyWith(
        items: value.items,
        hasNext: result.items.length == perPage,
        page: value.page + 1,
      );
    });
  }
}
