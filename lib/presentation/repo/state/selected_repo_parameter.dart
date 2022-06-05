// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/repo.dart';
import '../pages/view_page.dart';

part 'selected_repo_parameter.freezed.dart';

/// 選択中のリポジトリ用パラメータ
@freezed
class RepoSelectedRepoParameter with _$RepoSelectedRepoParameter {
  const factory RepoSelectedRepoParameter({
    /// オーナー名
    required String ownerName,

    /// リポジトリ名
    required String repoName,

    /// 一覧画面から渡されるリポジトリデータ
    /// 詳細画面で再読込した場合などは null になる場合がある
    Repo? extra,
  }) = _RepoSelectedRepoParameter;

  factory RepoSelectedRepoParameter.from(GoRouterState state) =>
      RepoSelectedRepoParameter(
        ownerName: state.params[pageParamKeyOwnerName]!,
        repoName: state.params[pageParamKeyRepoName]!,
        extra: state.extra as Repo?,
      );
}
