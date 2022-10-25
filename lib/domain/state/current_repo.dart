// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repositories/repo/entities/repo.dart';
import '../repositories/repo/repo_repository.dart';

part 'current_repo.freezed.dart';

/// 現在のリポジトリプロバイダー
final currentRepoProvider = FutureProvider.autoDispose<Repo>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// 現在のリポジトリプロバイダーFamily
final currentRepoProviderFamily =
    FutureProvider.family.autoDispose<Repo, CurrentRepoParam>(
  (ref, param) async {
    final repo = param.extra;
    if (repo != null) {
      // extra があればそのまま使う
      return repo;
    }

    // extra が無いので取得する
    final repoRepository = ref.watch(repoRepositoryProvider);
    return repoRepository.getRepo(
      ownerName: param.ownerName,
      repoName: param.repoName,
    );
  },
  name: 'currentRepoProvider',
);

/// 現在のリポジトリ用パラメーター
@freezed
class CurrentRepoParam with _$CurrentRepoParam {
  const factory CurrentRepoParam({
    /// オーナー名
    required String ownerName,

    /// リポジトリ名
    required String repoName,

    /// 一覧画面から渡されるリポジトリデータ
    /// 詳細画面で再読込した場合などは null になる場合がある
    Repo? extra,
  }) = _CurrentRepoParam;
}
