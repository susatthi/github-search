// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_list_view_state.dart';
import 'repo_search_text_field.dart';

final repoListViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoListViewController, AsyncValue<RepoListViewState>>(
  (ref) {
    final reposRepository = ref.watch(repoRepositoryProvider);
    final query = ref.watch(searchReposQueryProvider);
    logger.i('create RepoListViewController: query=$query');
    return RepoListViewController(
      reposRepository,
      query: query,
    );
  },
);

class RepoListViewController
    extends StateNotifier<AsyncValue<RepoListViewState>> {
  RepoListViewController(
    this._reposRepository, {
    required this.query,
  }) : super(const AsyncValue.loading()) {
    _search();
  }

  final RepoRepository _reposRepository;

  /// 検索文字列
  final String query;

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
