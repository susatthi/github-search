// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/repository/repo_repository.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_state.dart';

final repoListViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoListViewController, AsyncValue<RepoListViewState>>(
  (ref) {
    final reposRepository = ref.watch(repoRepositoryProvider);
    const query = 'susa';
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
    searchRepos(query: query);
  }

  final RepoRepository _reposRepository;
  final String query;

  Future<void> searchRepos({
    required String query,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _reposRepository.searchRepos(query: query);
      return RepoListViewState.from(result);
    });
  }
}
