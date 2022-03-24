// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/config/constants.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/logger.dart';
import 'package:github_search/repository/repo_repository.dart';

final repoDetailViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoDetailViewController, AsyncValue<RepoData>>(
  (ref) => throw StateError('Provider was not initialized'),
);

final repoDetailViewControllerProviderFamily = StateNotifierProvider.family
    .autoDispose<RepoDetailViewController, AsyncValue<RepoData>,
        Map<String, String>>(
  (ref, params) {
    final reposRepository = ref.watch(repoRepositoryProvider);
    final ownerName = params[kPageParamKeyOwnerName]!;
    final repoName = params[kPageParamKeyRepoName]!;
    logger
        .info('create RepoDetailViewController: fullName=$ownerName/$repoName');
    return RepoDetailViewController(
      reposRepository,
      ownerName: ownerName,
      repoName: repoName,
    );
  },
);

class RepoDetailViewController extends StateNotifier<AsyncValue<RepoData>> {
  RepoDetailViewController(
    this._reposRepository, {
    required this.ownerName,
    required this.repoName,
  }) : super(const AsyncValue.loading()) {
    _get();
  }

  final RepoRepository _reposRepository;

  /// オーナー名
  final String ownerName;

  /// リポジトリ名
  final String repoName;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = await _reposRepository.getRepo(
        ownerName: ownerName,
        repoName: repoName,
      );
      return RepoData.from(repo);
    });
  }
}
