// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/repo.dart';
import '../../../domain/entities/search_repos_order.dart';
import '../../../domain/entities/search_repos_result.dart';
import '../../../domain/entities/search_repos_sort.dart';
import '../../../domain/repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'search_repos_order.dart';
import 'search_repos_query.dart';
import 'search_repos_sort.dart';

part 'list_view_state.freezed.dart';

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

/// リポジトリ一覧View状態
@freezed
class RepoListViewState with _$RepoListViewState {
  const factory RepoListViewState({
    @Default(0) int totalCount,
    @Default(<Repo>[]) List<Repo> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
    @Default('') String query,
  }) = _RepoListViewState;

  factory RepoListViewState.from(SearchReposResult result) {
    return RepoListViewState(
      totalCount: result.totalCount,
      items: result.items,
      hasNext: result.items.length < result.totalCount,
      query: result.query,
    );
  }
}

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
  final SearchReposSort sort;

  /// 検索オーダー
  final SearchReposOrder order;

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
      return RepoListViewState.from(result);
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

      final appendedItems = result.items;
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
