// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'repo.dart';

part 'search_repos_result.freezed.dart';
part 'search_repos_result.g.dart';

/// リポジトリ検索結果JsonObject
@freezed
class SearchReposResultJsonObject with _$SearchReposResultJsonObject {
  const factory SearchReposResultJsonObject({
    @JsonKey(name: 'total_count') required int totalCount,
    required List<RepoJsonObject> items,
  }) = _SearchReposResultJsonObject;

  factory SearchReposResultJsonObject.fromJson(Map<String, dynamic> json) =>
      _$SearchReposResultJsonObjectFromJson(json);
}
