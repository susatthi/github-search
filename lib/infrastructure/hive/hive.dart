import 'package:hive_flutter/hive_flutter.dart';

import 'app_data/adapters/search_repos_order_adapter.dart';
import 'app_data/adapters/search_repos_sort_adapter.dart';

extension HiveEx on HiveInterface {
  /// アダプターを登録する
  void registerAdapters() {
    Hive
      ..registerAdapter(SearchReposSortAdapter())
      ..registerAdapter(SearchReposOrderAdapter());
  }
}
