// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/src/config/app.dart';

void main() {
  // CacheManagerのログレベルを設定する
  CacheManager.logLevel =
      kDebugMode ? CacheManagerLogLevel.verbose : CacheManagerLogLevel.none;

  runApp(
    ProviderScope(
      child: GithubSearchApp(),
    ),
  );
}
