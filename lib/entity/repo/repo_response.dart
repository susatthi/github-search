// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_response.freezed.dart';
part 'repo_response.g.dart';

/// 受信したリポジトリ
@freezed
class RepoResponse with _$RepoResponse {
  const factory RepoResponse({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
  }) = _RepoResponse;

  factory RepoResponse.fromJson(Map<String, dynamic> json) =>
      _$RepoResponseFromJson(json);
}

/// リポジトリ検索結果
@freezed
class SearchReposResultResponse with _$SearchReposResultResponse {
  const factory SearchReposResultResponse({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<RepoResponse> items,
  }) = _SearchReposResultResponse;

  factory SearchReposResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchReposResultResponseFromJson(json);
}
