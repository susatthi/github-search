// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/app_data/repositories/app_data_repository.dart';
import '../../../domain/repo/repositories/repo_repository.dart';

/// リポジトリ検索用ソート値プロバイダー
final repoSearchReposSortProvider =
    StateNotifierProvider<RepoSearchReposSortNotifier, RepoSearchReposSort>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return RepoSearchReposSortNotifier(
      appDataRepository,
    );
  },
);

/// リポジトリ検索用ソート値Notifier
class RepoSearchReposSortNotifier extends StateNotifier<RepoSearchReposSort> {
  RepoSearchReposSortNotifier(
    this._appDataRepository,
  ) : super(_appDataRepository.getSearchReposSort());

  final AppDataRepository _appDataRepository;

  /// ソート値を更新する
  // ignore: avoid_setters_without_getters
  set sort(RepoSearchReposSort sort) {
    _appDataRepository.setSearchReposSort(sort);
    state = _appDataRepository.getSearchReposSort();
  }
}
