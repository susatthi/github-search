// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import '../../pages/repo/repo_view_page.dart';

/// 選択中のリポジトリプロバイダー
final repoSelectedRepoProvider = StateNotifierProvider.autoDispose<
    RepoSelectedRepoNotifier, AsyncValue<RepoData>>(
  (ref) => throw StateError('Provider was not initialized'),
);

/// 選択中のリポジトリプロバイダー（Family）
final repoSelectedRepoProviderFamily = StateNotifierProvider.family.autoDispose<
    RepoSelectedRepoNotifier, AsyncValue<RepoData>, RepoSelectedRepoParameter>(
  (ref, parameter) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    logger.i('Create RepoSelectedRepoNotifier: parameter=$parameter');
    return RepoSelectedRepoNotifier(
      repoRepository,
      parameter: parameter,
    );
  },
);

/// 選択中のリポジトリ用パラメータ
class RepoSelectedRepoParameter extends Equatable {
  const RepoSelectedRepoParameter({
    required this.ownerName,
    required this.repoName,
    this.extra,
  });

  factory RepoSelectedRepoParameter.from(GoRouterState state) =>
      RepoSelectedRepoParameter(
        ownerName: state.params[pageParamKeyOwnerName]!,
        repoName: state.params[pageParamKeyRepoName]!,
        extra: state.extra as RepoData?,
      );

  /// オーナー名
  final String ownerName;

  /// リポジトリ名
  final String repoName;

  /// 一覧画面から渡されるリポジトリデータ
  /// 詳細画面で再読込した場合などは null になる場合がある
  final RepoData? extra;

  @override
  List<Object?> get props => [ownerName, repoName, extra];
}

/// 選択中のリポジトリNotifier
class RepoSelectedRepoNotifier extends StateNotifier<AsyncValue<RepoData>> {
  RepoSelectedRepoNotifier(
    this._repoRepository, {
    required this.parameter,
  }) : super(const AsyncValue.loading()) {
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
  final RepoSelectedRepoParameter parameter;

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