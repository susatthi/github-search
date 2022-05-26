// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/search_repos_sort.dart';
import '../../../domain/repositories/app_data_repository.dart';

/// リポジトリ検索用ソート値プロバイダー
final repoSearchReposSortProvider =
    StateNotifierProvider<RepoSearchReposSortNotifier, SearchReposSort>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return RepoSearchReposSortNotifier(
      appDataRepository,
    );
  },
);

/// リポジトリ検索用ソート値Notifier
class RepoSearchReposSortNotifier extends StateNotifier<SearchReposSort> {
  RepoSearchReposSortNotifier(
    this._appDataRepository,
  ) : super(_appDataRepository.getSearchReposSort());

  final AppDataRepository _appDataRepository;

  /// ソート値を更新する
  // ignore: avoid_setters_without_getters
  set sort(SearchReposSort sort) {
    _appDataRepository.setSearchReposSort(sort);
    state = _appDataRepository.getSearchReposSort();
  }
}
