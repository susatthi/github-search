// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../entities/repo/repo_data.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';

final repoDetailViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoDetailViewController, AsyncValue<RepoData>>(
  (ref) => throw StateError('Provider was not initialized'),
);

final repoDetailViewControllerProviderFamily = StateNotifierProvider.family
    .autoDispose<RepoDetailViewController, AsyncValue<RepoData>,
        RepoDetailViewParameter>(
  (ref, parameter) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    logger.i('create RepoDetailViewController: parameter=$parameter');
    return RepoDetailViewController(
      repoRepository,
      parameter: parameter,
    );
  },
);

/// パラメータ
class RepoDetailViewParameter extends Equatable {
  const RepoDetailViewParameter({
    required this.ownerName,
    required this.repoName,
  });

  factory RepoDetailViewParameter.from(GoRouterState state) =>
      RepoDetailViewParameter(
        ownerName: state.params[kPageParamKeyOwnerName]!,
        repoName: state.params[kPageParamKeyRepoName]!,
      );

  /// オーナー名
  final String ownerName;

  /// リポジトリ名
  final String repoName;

  @override
  List<Object?> get props => [ownerName, repoName];
}

class RepoDetailViewController extends StateNotifier<AsyncValue<RepoData>> {
  RepoDetailViewController(
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
