// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/repo_search_repos_order.dart';
import '../entities/repo_search_repos_sort.dart';

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => throw UnimplementedError(),
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// デフォルト値
  static const defaultValues = <AppDataKey, Object?>{
    AppDataKey.repoSearchReposSort: RepoSearchReposSort.bestMatch,
    AppDataKey.repoSearchReposOrder: RepoSearchReposOrder.desc,
  };

  /// リポジトリ検索用ソート値を設定する
  void setSearchReposSort(RepoSearchReposSort sort);

  /// リポジトリ検索用ソート値を返す
  RepoSearchReposSort getSearchReposSort();

  /// リポジトリ検索用オーダー値を設定する
  void setSearchReposOrder(RepoSearchReposOrder order);

  /// リポジトリ検索用オーダー値を返す
  RepoSearchReposOrder getSearchReposOrder();
}

/// アプリデータのキー名
enum AppDataKey {
  /// リポジトリ検索ソート値
  repoSearchReposSort,

  /// リポジトリ検索オーダー値
  repoSearchReposOrder,
}
