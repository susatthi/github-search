// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exceptions.dart';

part 'query_string.freezed.dart';

/// 検索文字列
@freezed
class QueryString with _$QueryString {
  factory QueryString([
    @Default('') String value,
  ]) = _QueryString;

  QueryString._() {
    // 前後に空白があったらエラーにする
    if (value.length != value.trim().length) {
      throw ValidatorException.invalidArgument();
    }
    // 空文字はエラーにする
    if (value.isEmpty) {
      throw ValidatorException.invalidArgument();
    }
  }
}
