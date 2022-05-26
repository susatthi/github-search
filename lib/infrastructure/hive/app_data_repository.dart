// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/search_repos_order.dart';
import '../../domain/entities/search_repos_sort.dart';
import '../../domain/repositories/app_data_repository.dart';

/// Hive の Box 名
const hiveBoxNameAppData = 'appData';

/// Hive版アプリデータRepositoryプロバイダー
final hiveAppDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) {
    final box = Hive.box<dynamic>(hiveBoxNameAppData);
    return HiveAppDataRepository(
      box: box,
    );
  },
);

/// Hive版アプリデータRepository
class HiveAppDataRepository implements AppDataRepository {
  const HiveAppDataRepository({
    required Box<dynamic> box,
  }) : _box = box;

  /// Hive Box
  final Box<dynamic> _box;

  /// デフォルト値を返す
  /// キーが見つからない場合は IterableElementError.noElement() を投げる
  T? _getDefaultValue<T>(AppDataKey key) =>
      AppDataRepository.defaultValues.entries
          .firstWhere((element) => element.key == key)
          .value as T?;

  @override
  void setSearchReposSort(SearchReposSort sort) {
    _box.put(AppDataKey.searchReposSort.name, sort.name);
  }

  @override
  SearchReposSort getSearchReposSort() {
    final defaultValue = _getDefaultValue<SearchReposSort>(
      AppDataKey.searchReposSort,
    );
    final name = _box.get(
      AppDataKey.searchReposSort.name,
      defaultValue: defaultValue?.name,
    ) as String;
    return SearchReposSort.valueOf(name);
  }

  @override
  void setSearchReposOrder(SearchReposOrder order) {
    _box.put(AppDataKey.searchReposOrder.name, order.name);
  }

  @override
  SearchReposOrder getSearchReposOrder() {
    final defaultValue = _getDefaultValue<SearchReposOrder>(
      AppDataKey.searchReposOrder,
    );
    final name = _box.get(
      AppDataKey.searchReposOrder.name,
      defaultValue: defaultValue?.name,
    ) as String;
    return SearchReposOrder.valueOf(name);
  }
}
