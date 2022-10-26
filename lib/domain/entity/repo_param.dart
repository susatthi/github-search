// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repository/repo/entity/repo.dart';

part 'repo_param.freezed.dart';

/// 現在のリポジトリプロバイダー
final currentRepoParamProvider = StateProvider<RepoParam?>(
  (ref) => null,
);

/// リポジトリパラメーター
@freezed
class RepoParam with _$RepoParam {
  const factory RepoParam({
    /// オーナー名
    required String ownerName,

    /// リポジトリ名
    required String repoName,

    /// 一覧画面から渡されるリポジトリデータ
    /// 詳細画面で再読込した場合などは null になる場合がある
    Repo? extra,
  }) = _RepoParam;
}
