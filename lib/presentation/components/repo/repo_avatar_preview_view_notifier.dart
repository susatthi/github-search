// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_detail_view_notifier.dart';

/// アバター画像プレビューView状態プロバイダー
final repoAvatarPreviewViewStateProvider = StateNotifierProvider.autoDispose<
    RepoAvatarPreviewViewNotifier, AsyncValue<RepoData>>(
  (ref) => throw StateError('Provider was not initialized'),
);

/// アバター画像プレビューView状態プロバイダー（Family）
final repoAvatarPreviewViewStateProviderFamily = StateNotifierProvider.family
    .autoDispose<RepoAvatarPreviewViewNotifier, AsyncValue<RepoData>,
        RepoDetailViewParameter>(
  (ref, parameter) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    logger.i('Create RepoAvatarPreviewViewNotifier: parameter=$parameter');
    return RepoAvatarPreviewViewNotifier(
      repoRepository,
      parameter: parameter,
    );
  },
);

/// アバター画像プレビューViewNotifier
class RepoAvatarPreviewViewNotifier
    extends StateNotifier<AsyncValue<RepoData>> {
  RepoAvatarPreviewViewNotifier(
    this._repoRepository, {
    required this.parameter,
  }) : super(const AsyncValue.loading()) {
    _get();
  }

  final RepoRepository _repoRepository;

  /// パラメータ
  final RepoDetailViewParameter parameter;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = await _repoRepository.getRepo(
        ownerName: parameter.ownerName,
        repoName: parameter.repoName,
      );
      return RepoData.from(repo);
    });
  }
}
