// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/src/entities/repo/repo_data.dart';
import 'package:github_search/src/entities/repo/search_repos_result.dart';

part 'repo_list_view_state.freezed.dart';

@freezed
class RepoListViewState with _$RepoListViewState {
  const factory RepoListViewState({
    @Default(<RepoData>[]) List<RepoData> items,
    @Default(false) bool hasNext,
    @Default(1) int page,
  }) = _RepoListViewState;

  factory RepoListViewState.from(SearchReposResult result) {
    return RepoListViewState(
      items: result.items.map(RepoData.from).toList(),
      hasNext: result.items.length < result.totalCount,
    );
  }
}
