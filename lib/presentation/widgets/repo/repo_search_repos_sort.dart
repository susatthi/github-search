// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/app_data_repository.dart';
import '../../../repositories/repo_repository.dart';

final repoSearchReposSortProvider = StateNotifierProvider<
    RepoSearchReposSortController, RepoParamSearchReposSort>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return RepoSearchReposSortController(
      appDataRepository,
    );
  },
);

class RepoSearchReposSortController
    extends StateNotifier<RepoParamSearchReposSort> {
  RepoSearchReposSortController(
    this._appDataRepository,
  ) : super(_appDataRepository.getSearchReposSort());

  final AppDataRepository _appDataRepository;

  /// ソートを更新する
  void update({
    required RepoParamSearchReposSort sort,
  }) {
    _appDataRepository.setSearchReposSort(sort);
    state = _appDataRepository.getSearchReposSort();
  }
}
