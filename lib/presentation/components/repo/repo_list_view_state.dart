// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../entities/search_repos_result/search_repos_result.dart';

part 'repo_list_view_state.freezed.dart';

/// リポジトリ一覧View状態
@freezed
class RepoListViewState with _$RepoListViewState {
  const factory RepoListViewState({
    @Default(<RepoData>[]) List<RepoData> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
    @Default('') String query,
  }) = _RepoListViewState;

  factory RepoListViewState.from(SearchReposResult result, String query) {
    return RepoListViewState(
      items: result.items.map(RepoData.from).toList(),
      hasNext: result.items.length < result.totalCount,
      query: query,
    );
  }
}
