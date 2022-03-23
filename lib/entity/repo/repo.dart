// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// リポジトリEntity
@freezed
class Repo with _$Repo {
  const factory Repo({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
}

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
