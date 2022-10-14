// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// リポジトリ検索用オーダー
enum SearchReposOrder {
  desc,
  asc,
  ;

  /// name からオーダーを返す
  /// 見つからない場合は IterableElementError.noElement() を投げる
  static SearchReposOrder nameOf(String name) {
    return SearchReposOrder.values
        .firstWhere((element) => element.name == name);
  }
}
