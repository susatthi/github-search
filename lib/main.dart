// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/config/github_search_app.dart';

import 'utils/url_strategy/url_strategy.dart';

void main() {
  // CacheManagerのログレベルを設定する
  CacheManager.logLevel =
      kDebugMode ? CacheManagerLogLevel.verbose : CacheManagerLogLevel.none;

  // Web版のURLの#を除去する
  // see: https://docs.flutter.dev/development/ui/navigation/url-strategies
  usePathUrlStrategy();

  runApp(
    ProviderScope(
      child: GitHubSearchApp(),
    ),
  );
}
