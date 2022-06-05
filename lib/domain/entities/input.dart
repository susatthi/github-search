// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: comment_references

/// 入力Entity
///
/// 入力Entityは [InputEntity] を with すること
mixin InputEntity {
  /// Entityを検査をする
  ///
  /// 検査でエラーがある場合は [ValidatorException] を投げること
  void validate();
}
