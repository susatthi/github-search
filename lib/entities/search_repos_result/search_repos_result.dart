// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../repo/repo.dart';

part 'search_repos_result.freezed.dart';
part 'search_repos_result.g.dart';

/// リポジトリ検索結果Entity
@freezed
class SearchReposResult with _$SearchReposResult {
  const factory SearchReposResult({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<Repo> items,
  }) = _SearchReposResult;

  factory SearchReposResult.fromJson(Map<String, dynamic> json) =>
      _$SearchReposResultFromJson(json);
}
