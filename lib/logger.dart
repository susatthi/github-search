// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger()
  ..formatter = (info) {
    return '[APP/${info.level}] '
        '${DateFormat('HH:mm:ss.SSS').format(info.time)} '
        '[${info.callerFrame ?? 'caller info not available'}] '
        '${info.message}';
  }
  ..setLevel(
    const bool.fromEnvironment('dart.vm.product') ? Level.OFF : Level.ALL,
    includeCallerInfo: true,
  )
  ..onLogged = (log, info) {
    if (info.level >= Level.SEVERE) {
      // 致命的なエラーが発生したのでデバッグ実行のときはAssertで止める
      // Crashlysticsでログを飛ばすのもあり
      assert(false);
    }
  };
