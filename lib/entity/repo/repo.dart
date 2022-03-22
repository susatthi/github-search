// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// リポジトリ
@freezed
class Repo with _$Repo {
  const factory Repo({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
}

/// リポジトリ検索結果
@freezed
class ReposResult with _$ReposResult {
  const factory ReposResult({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<Repo> items,
  }) = _ReposResult;

  factory ReposResult.fromJson(Map<String, dynamic> json) =>
      _$ReposResultFromJson(json);
}
