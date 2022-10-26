// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// リポジトリ検索用ソート
enum SearchReposSort {
  bestMatch,
  stars,
  forks,
  helpWantedIssues,
  ;

  /// name からソートを返す
  /// 見つからない場合は IterableElementError.noElement() を投げる
  static SearchReposSort nameOf(String name) {
    return SearchReposSort.values.firstWhere((element) => element.name == name);
  }
}
