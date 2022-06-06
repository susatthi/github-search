// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/repo_repository.dart';
import '../../../../utils/logger.dart';

/// READMEコンテンツプロバイダー（Family）
final readmeContentProviderFamily = StateNotifierProvider.family
    .autoDispose<ReadmeContentNotifier, AsyncValue<String>, Repo>(
  (ref, repo) {
    logger.i(
      'Create ReadmeContentNotifier: fullName = ${repo.fullName}, '
      'defaultBranch = ${repo.defaultBranch}',
    );
    return ReadmeContentNotifier(
      ref.read,
      repo: repo,
    );
  },
);

/// READMEコンテンツNotifier
class ReadmeContentNotifier extends StateNotifier<AsyncValue<String>> {
  ReadmeContentNotifier(
    Reader read, {
    required this.repo,
  })  : _repoRepository = read(repoRepositoryProvider),
        super(const AsyncValue.loading()) {
    _get();
  }

  final RepoRepository _repoRepository;

  /// リポジトリEntity
  final Repo repo;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _repoRepository.getReadme(
        repo: repo,
      );
    });
  }
}
