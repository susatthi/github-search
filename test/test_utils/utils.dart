// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

class TestAssets {
  /// テキストファイルを読み込む
  static String? readString(String path) {
    var dir = Directory.current.path;
    if (dir.endsWith('/test')) {
      dir = dir.replaceAll('/test', '');
    }
    final file = File('$dir/test/test_utils/assets/$path');
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsStringSync();
  }

  /// JSONマップを読み込む
  static Map<String, dynamic>? readJsonMap(String path) {
    final jsonString = TestAssets.readString(path);
    return jsonString != null
        ? json.decode(jsonString) as Map<String, dynamic>
        : null;
  }
}
