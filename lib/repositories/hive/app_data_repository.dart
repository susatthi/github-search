// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/constants.dart';
import '../app_data_repository.dart';
import '../repo_repository.dart';

/// Hive版アプリデータRepositoryプロバイダー
final hiveAppDataRepositoryProvider = Provider<HiveAppDataRepository>(
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
  void setSearchReposSort(RepoParamSearchReposSort sort) {
    _box.put(AppDataKey.searchReposSort.name, sort.name);
  }

  @override
  RepoParamSearchReposSort getSearchReposSort() {
    final defaultValue = _getDefaultValue<RepoParamSearchReposSort>(
      AppDataKey.searchReposSort,
    );
    final name = _box.get(
      AppDataKey.searchReposSort.name,
      defaultValue: defaultValue?.name,
    ) as String;
    return RepoParamSearchReposSortHelper.valueOf(name);
  }

  @override
  void setSearchReposOrder(RepoParamSearchReposOrder order) {
    _box.put(AppDataKey.searchReposOrder.name, order.name);
  }

  @override
  RepoParamSearchReposOrder getSearchReposOrder() {
    final defaultValue = _getDefaultValue<RepoParamSearchReposOrder>(
      AppDataKey.searchReposOrder,
    );
    final name = _box.get(
      AppDataKey.searchReposOrder.name,
      defaultValue: defaultValue?.name,
    ) as String;
    return RepoParamSearchReposOrderHelper.valueOf(name);
  }
}
