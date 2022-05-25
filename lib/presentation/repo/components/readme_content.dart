// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/repo.dart';
import '../../../domain/repositories/repo_repository.dart';
import '../../../utils/logger.dart';

/// リポジトリREADMEコンテンツプロバイダー（Family）
final repoReadmeContentProviderFamily = StateNotifierProvider.family
    .autoDispose<RepoReadmeContentNotifier, AsyncValue<String>, Repo>(
  (ref, repo) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    logger.i(
      'Create RepoReadmeContentNotifier: fullName = ${repo.fullName}, '
      'defaultBranch = ${repo.defaultBranch}',
    );
    return RepoReadmeContentNotifier(
      repoRepository,
      repo: repo,
    );
  },
);

/// リポジトリREADMEコンテンツNotifier
class RepoReadmeContentNotifier extends StateNotifier<AsyncValue<String>> {
  RepoReadmeContentNotifier(
    this._repoRepository, {
    required this.repo,
  }) : super(const AsyncValue.loading()) {
    _get();
  }

  final RepoRepository _repoRepository;

  /// リポジトリ
  final Repo repo;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _repoRepository.getReadme(
        ownerName: repo.owner.name,
        repoName: repo.name,
        defaultBranch: repo.defaultBranch,
      );
    });
  }
}
