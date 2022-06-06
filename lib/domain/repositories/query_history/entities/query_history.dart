// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_history.freezed.dart';

/// 検索履歴Entity
@freezed
class QueryHistory with _$QueryHistory {
  const factory QueryHistory({
    /// 検索文字列
    required String queryString,
  }) = _QueryHistory;
}
