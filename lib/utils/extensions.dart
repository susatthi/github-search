// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueEx<T> on AsyncValue<T> {
  /// エラーのみ処理する
  void whenError(
    void Function(Object error, StackTrace? stackTrace) error,
  ) {
    return map<void>(
      data: (_) {},
      error: (e) => error(e.error, e.stackTrace),
      loading: (_) {},
    );
  }
}
