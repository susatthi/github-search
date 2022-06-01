// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions.dart';
import 'input.dart';

part 'query_history_input.freezed.dart';

/// 検索履歴入力Entity
@freezed
class QueryHistoryInput with _$QueryHistoryInput, InputEntity {
  factory QueryHistoryInput({
    /// 検索文字列
    required String queryString,
  }) = _QueryHistoryInput;

  QueryHistoryInput._();

  @override
  void validate() {
    if (queryString.trim().isEmpty) {
      throw ValidatorException.invalidArgument('queryString');
    }
  }
}
