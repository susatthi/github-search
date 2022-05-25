// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/hive/app_data_repository.dart';
import '../repositories/repo_repository.dart';

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => ref.watch(hiveAppDataRepositoryProvider),
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// デフォルト値
  static const defaultValues = <AppDataKey, Object?>{
    AppDataKey.repoSearchReposSort: RepoSearchReposSort.bestMatch,
    AppDataKey.repoSearchReposOrder: RepoSearchReposOrder.desc,
  };

  /// リポジトリ検索用ソートを設定する
  void setSearchReposSort(RepoSearchReposSort sort);

  /// リポジトリ検索用ソートを返す
  RepoSearchReposSort getSearchReposSort();

  /// リポジトリ検索用オーダーを設定する
  void setSearchReposOrder(RepoSearchReposOrder order);

  /// リポジトリ検索用オーダーを設定する
  RepoSearchReposOrder getSearchReposOrder();
}

/// アプリデータのキー名
enum AppDataKey {
  /// リポジトリ検索ソート値
  repoSearchReposSort,

  /// リポジトリ検索オーダー値
  repoSearchReposOrder,
}
