// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/search_repos_query.dart';
import '../../domain/repository/app_data/app_data_repository.dart';
import '../../domain/repository/repo/entity/repo.dart';
import '../../domain/repository/repo/entity/search_repos_order.dart';
import '../../domain/repository/repo/entity/search_repos_result.dart';
import '../../domain/repository/repo/entity/search_repos_sort.dart';
import '../../domain/repository/repo/repo_repository.dart';
import '../../util/logger.dart';

part 'repos_query.freezed.dart';

/// リポジトリ一覧クエリデータプロバイダー
final reposQueryDataProvider = StateNotifierProvider.autoDispose<
    ReposQueryDataNotifier, AsyncValue<ReposQueryData>>(
  (ref) => ReposQueryDataNotifier(
    repoRepository: ref.watch(repoRepositoryProvider),
    queryString: ref.watch(searchReposQueryProvider),
    sort: ref.watch(searchReposSortProvider),
    order: ref.watch(searchReposOrderProvider),
  ),
  name: 'reposQueryDataProvider',
);

/// リポジトリ一覧クエリデータ
@freezed
class ReposQueryData with _$ReposQueryData {
  const factory ReposQueryData({
    @Default(0) int totalCount,
    @Default(<Repo>[]) List<Repo> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
    @Default('') String queryString,
  }) = _ReposQueryData;

  factory ReposQueryData.from(SearchReposResult result) {
    return ReposQueryData(
      totalCount: result.totalCount,
      items: result.items,
      hasNext: result.items.length < result.totalCount,
      queryString: result.queryString,
    );
  }
}

/// リポジトリ一覧クエリデータNotifier
class ReposQueryDataNotifier extends StateNotifier<AsyncValue<ReposQueryData>> {
  ReposQueryDataNotifier({
    required this.repoRepository,
    required this.queryString,
    required this.sort,
    required this.order,
  }) : super(const AsyncValue.loading()) {
    // 検索を実行する
    () async {
      state = await AsyncValue.guard(() async {
        final trimQueryString = queryString.trim();
        if (trimQueryString.isEmpty) {
          return const ReposQueryData();
        }

        final result = await repoRepository.searchRepos(
          queryString: trimQueryString,
          sort: sort,
          order: order,
          perPage: perPage,
        );
        logger.i(
          'Search repos result: totalCount = ${result.totalCount}, '
          'fetchItems = ${result.items.length}',
        );
        return ReposQueryData.from(result);
      });
    }();
  }

  final RepoRepository repoRepository;

  /// 検索文字列
  final String queryString;

  /// 検索ソート
  final SearchReposSort sort;

  /// 検索オーダー
  final SearchReposOrder order;

  /// 1ページに取得するレポジトリの数
  static const perPage = 30;

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
      final result = await repoRepository.searchRepos(
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
