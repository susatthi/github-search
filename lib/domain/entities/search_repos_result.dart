// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'repo.dart';

part 'search_repos_result.freezed.dart';

/// リポジトリ検索結果Entity
@freezed
class SearchReposResult with _$SearchReposResult {
  const factory SearchReposResult({
    /// 検索結果トータル件数
    required int totalCount,

    /// リポジトリEntityのリスト
    required List<Repo> items,
  }) = _SearchReposResult;
}
