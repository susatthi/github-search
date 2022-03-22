// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/repository/repo_repository.dart';

final repoListViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoListViewController, AsyncValue<List<RepoData>>>(
  (ref) {
    final reposRepository = ref.watch(repoRepositoryProvider);
    return RepoListViewController(reposRepository, query: '');
  },
);

class RepoListViewController extends StateNotifier<AsyncValue<List<RepoData>>> {
  RepoListViewController(
    this._reposRepository, {
    required this.query,
  }) : super(const AsyncValue.loading()) {
    searchRepos(query: query);
  }

  final RepoRepository _reposRepository;
  final String query;

  Future<void> searchRepos({
    required String query,
  }) async {
    state = const AsyncValue.loading();
    final repos = await _reposRepository.searchRepos(query: query);
    state = AsyncValue.data(repos.map(RepoData.from).toList());
  }
}