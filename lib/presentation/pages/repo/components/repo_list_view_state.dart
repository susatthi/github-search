// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/entities/search_repos_order.dart';
import '../../../../domain/repositories/repo/entities/search_repos_result.dart';
import '../../../../domain/repositories/repo/entities/search_repos_sort.dart';
import '../../../../domain/repositories/repo/repo_repository.dart';
import '../../../../utils/logger.dart';
import 'search_repos_order_toggle_button.dart';
import 'search_repos_query.dart';
import 'search_repos_sort_selector_bottom_sheet.dart';

part 'repo_list_view_state.freezed.dart';

/// リポジトリ一覧View状態プロバイダー
final repoListViewStateProvider = StateNotifierProvider.autoDispose<
    RepoListViewNotifier, AsyncValue<RepoListViewState>>(
  (ref) {
    final queryString = ref.watch(searchReposQueryStringProvider);
    final sort = ref.watch(searchReposSortProvider);
    final order = ref.watch(searchReposOrderProvider);
    logger.i(
      'Create RepoListViewNotifier: queryString = $queryString, '
      'sort = ${sort.name}, order = ${order.name}',
    );
    return RepoListViewNotifier(
      ref.read,
      queryString: queryString,
      sort: sort,
      order: order,
    );
  },
);

/// リポジトリ一覧View状態
@freezed
class RepoListViewState with _$RepoListViewState {
  const factory RepoListViewState({
    @Default(0) int totalCount,
    @Default(<Repo>[]) List<Repo> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
    @Default('') String queryString,
  }) = _RepoListViewState;

  factory RepoListViewState.from(SearchReposResult result) {
    return RepoListViewState(
      totalCount: result.totalCount,
      items: result.items,
      hasNext: result.items.length < result.totalCount,
      queryString: result.queryString,
    );
  }
}

/// リポジトリ一覧ViewNotifier
class RepoListViewNotifier
    extends StateNotifier<AsyncValue<RepoListViewState>> {
  RepoListViewNotifier(
    Reader read, {
    required this.queryString,
    required this.sort,
    required this.order,
  })  : _repoRepository = read(repoRepositoryProvider),
        super(const AsyncValue.loading()) {
    _search();
  }

  final RepoRepository _repoRepository;

  /// 検索文字列
  final String queryString;

  /// 検索ソート
  final SearchReposSort sort;

  /// 検索オーダー
  final SearchReposOrder order;

  /// 1ページに取得するレポジトリの数
  static const perPage = 30;

  Future<void> _search() async {
    state = await AsyncValue.guard(() async {
      final trimQueryString = queryString.trim();
      if (trimQueryString.isEmpty) {
        return const RepoListViewState();
      }

      final result = await _repoRepository.searchRepos(
        queryString: trimQueryString,
        sort: sort,
        order: order,
        perPage: perPage,
      );
      logger.i(
        'Search repos result: totalCount = ${result.totalCount}, '
        'fetchItems = ${result.items.length}',
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
      final result = await _repoRepository.searchRepos(
        queryString: queryString,
        sort: sort,
        order: order,
        perPage: perPage,
        page: value.page + 1,
      );

      final appendedItems = result.items;
      logger.i(
        'Search repos result: totalCount = ${result.totalCount}, '
        'fetchItems = ${result.items.length}, '
        'totalItems = ${value.items.length + appendedItems.length}',
      );
      return value.copyWith(
        items: value.items + appendedItems,
        hasNext: result.items.length == perPage,
        page: value.page + 1,
      );
    });
  }
}
