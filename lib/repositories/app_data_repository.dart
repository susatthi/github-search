// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/repositories/repo_repository.dart';

import 'hive/app_data_repository.dart';

final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) {
    final box = ref.watch(appDataBoxProvider);
    return HiveAppDataRepository(
      box: box,
    );
  },
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// デフォルト値
  static const defaultValues = <AppDataKey, Object?>{
    AppDataKey.searchReposSort: RepoParamSearchReposSort.bestMatch,
    AppDataKey.searchReposOrder: RepoParamSearchReposOrder.desc,
  };

  /// リポジトリ検索用ソートを設定する
  void setSearchReposSort(RepoParamSearchReposSort sort);

  /// リポジトリ検索用ソートを返す
  RepoParamSearchReposSort getSearchReposSort();

  /// リポジトリ検索用オーダーを設定する
  void setSearchReposOrder(RepoParamSearchReposOrder order);

  /// リポジトリ検索用オーダーを設定する
  RepoParamSearchReposOrder getSearchReposOrder();
}

/// データのキー名
enum AppDataKey {
  searchReposSort,
  searchReposOrder,
}
