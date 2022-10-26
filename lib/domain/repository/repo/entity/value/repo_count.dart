// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_display/number_display.dart';

part 'repo_count.freezed.dart';

/// カウント
@freezed
class RepoCount with _$RepoCount {
  const factory RepoCount([
    @Default(0) int value,
  ]) = _RepoCount;

  const RepoCount._();

  /// 表示用（例：35432 => 35.4k）
  String get display => createDisplay(length: 4)(value);
}
