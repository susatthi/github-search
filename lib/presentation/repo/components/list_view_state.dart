// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/repo.dart';
import '../../../domain/entities/search_repos_result.dart';

part 'list_view_state.freezed.dart';

/// リポジトリ一覧View状態
@freezed
class RepoListViewState with _$RepoListViewState {
  const factory RepoListViewState({
    @Default(0) int totalCount,
    @Default(<Repo>[]) List<Repo> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
    @Default('') String query,
  }) = _RepoListViewState;

  factory RepoListViewState.from(
    SearchReposResult result,
    String query,
  ) {
    return RepoListViewState(
      totalCount: result.totalCount,
      items: result.items,
      hasNext: result.items.length < result.totalCount,
      query: query,
    );
  }
}
