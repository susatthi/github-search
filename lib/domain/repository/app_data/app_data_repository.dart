// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/entity/search_repos_order.dart';
import '../repo/entity/search_repos_sort.dart';
import 'entity/app_data_key.dart';

/// リポジトリ検索用オーダー値プロバイダー
final searchReposOrderProvider = StateProvider(
  (ref) {
    const key = AppDataKey.searchReposOrder;
    final repository = ref.watch(appDataRepositoryProvider);
    repository.changes<SearchReposOrder>(key).listen(
      (order) {
        ref.controller.state = order;
      },
    );
    return repository.get<SearchReposOrder>(key);
  },
);

/// リポジトリ検索用ソート値プロバイダー
final searchReposSortProvider = StateProvider(
  (ref) {
    const key = AppDataKey.searchReposSort;
    final repository = ref.watch(appDataRepositoryProvider);
    repository.changes<SearchReposSort>(key).listen(
      (order) {
        ref.controller.state = order;
      },
    );
    return repository.get<SearchReposSort>(key);
  },
);

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// 値を設定する
  void set<T extends Object?>(AppDataKey key, T value);

  /// 値を返す
  T get<T extends Object?>(AppDataKey key);

  /// Stream を返す
  Stream<T> changes<T extends Object?>(AppDataKey key);
}
