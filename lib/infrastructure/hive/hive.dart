import 'package:hive_flutter/hive_flutter.dart';

import 'app_data/adapters/search_repos_order_adapter.dart';
import 'app_data/adapters/search_repos_sort_adapter.dart';
import 'app_data/app_data_repository.dart';

/// Hive を初期化する
Future<void> initHive() async {
  await Hive.initFlutter();

  // アダプターを登録する
  // アダプターを追加したら登録を忘れずに行うこと
  Hive
    ..registerAdapter(SearchReposSortAdapter())
    ..registerAdapter(SearchReposOrderAdapter());

  // Boxを開く
  await Hive.openBox<dynamic>(hiveBoxNameAppData);
  // await Hive.box<dynamic>(hiveBoxNameAppData).clear();
}
