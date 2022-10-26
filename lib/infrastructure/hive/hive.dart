// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:hive_flutter/hive_flutter.dart';

import 'app_data/adapter/search_repos_order_adapter.dart';
import 'app_data/adapter/search_repos_sort_adapter.dart';

extension HiveEx on HiveInterface {
  /// アダプターを登録する
  void registerAdapters() {
    Hive
      ..registerAdapter(SearchReposSortAdapter())
      ..registerAdapter(SearchReposOrderAdapter());
  }
}
