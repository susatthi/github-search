// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/repo_repository.dart';

part 'selected_repo.freezed.dart';

/// 選択中のリポジトリプロバイダー
final selectedRepoProvider = FutureProvider.autoDispose<Repo>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// 選択中のリポジトリプロバイダーFamily
final selectedRepoProviderFamily =
    FutureProvider.family.autoDispose<Repo, SelectedRepoParameter>(
  (ref, parameter) async {
    final repo = parameter.extra;
    if (repo != null) {
      // extra があればそのまま使う
      return repo;
    }

    // extra が無いので取得する
    final repoRepository = ref.watch(repoRepositoryProvider);
    return repoRepository.getRepo(
      ownerName: parameter.ownerName,
      repoName: parameter.repoName,
    );
  },
  name: 'selectedRepoProvider',
);

/// 選択中のリポジトリ用パラメータ
@freezed
class SelectedRepoParameter with _$SelectedRepoParameter {
  const factory SelectedRepoParameter({
    /// オーナー名
    required String ownerName,

    /// リポジトリ名
    required String repoName,

    /// 一覧画面から渡されるリポジトリデータ
    /// 詳細画面で再読込した場合などは null になる場合がある
    Repo? extra,
  }) = _SelectedRepoParameter;
}
