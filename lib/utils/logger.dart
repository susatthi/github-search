// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:roggle/roggle.dart';

final logger = Roggle(
  printer: SinglePrettyPrinter(
    loggerName: ' [APP]',
    // warning 以上のときはスタックトレースを出力する
    stackTraceLevel: Level.warning,
    // iOS はカラー非対応
    colors: !Platform.isIOS,
    // ログが長くなるので非表示
    printCaller: false,
  ),
  output: _AssertionOutput(),
);

class _AssertionOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);

    // wtf 以上のときは処理を停止する
    if (event.level.index >= Level.wtf.index) {
      throw AssertionError('Stopped by logger.');
    }
  }
}
