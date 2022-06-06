// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/repo_repository.dart';
import '../../../../utils/logger.dart';
import 'selected_repo_parameter.dart';

/// 選択中のリポジトリプロバイダー
final selectedRepoProvider =
    StateNotifierProvider.autoDispose<SelectedRepoNotifier, AsyncValue<Repo>>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// 選択中のリポジトリプロバイダー（Family）
final selectedRepoProviderFamily = StateNotifierProvider.family
    .autoDispose<SelectedRepoNotifier, AsyncValue<Repo>, SelectedRepoParameter>(
  (ref, parameter) {
    logger.i('Create SelectedRepoNotifier: parameter = $parameter');
    return SelectedRepoNotifier(
      ref.read,
      parameter: parameter,
    );
  },
);

/// 選択中のリポジトリNotifier
class SelectedRepoNotifier extends StateNotifier<AsyncValue<Repo>> {
  SelectedRepoNotifier(
    Reader read, {
    required this.parameter,
  })  : _repoRepository = read(repoRepositoryProvider),
        super(const AsyncValue.loading()) {
    final value = parameter.extra;
    if (value != null) {
      // extra があればそのまま使う
      state = AsyncValue.data(value);
    } else {
      // extra が無いので取得する
      _get();
    }
  }

  final RepoRepository _repoRepository;

  /// パラメータ
  final SelectedRepoParameter parameter;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _repoRepository.getRepo(
        ownerName: parameter.ownerName,
        repoName: parameter.repoName,
      );
    });
  }
}
