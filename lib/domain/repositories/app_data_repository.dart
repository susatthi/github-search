// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/search_repos_order.dart';
import '../entities/search_repos_sort.dart';

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => throw UnimplementedError(),
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// デフォルト値
  static const defaultValues = <AppDataKey, Object?>{
    AppDataKey.searchReposSort: SearchReposSort.bestMatch,
    AppDataKey.searchReposOrder: SearchReposOrder.desc,
  };

  /// リポジトリ検索用ソート値を設定する
  void setSearchReposSort(SearchReposSort sort);

  /// リポジトリ検索用ソート値を返す
  SearchReposSort getSearchReposSort();

  /// リポジトリ検索用オーダー値を設定する
  void setSearchReposOrder(SearchReposOrder order);

  /// リポジトリ検索用オーダー値を返す
  SearchReposOrder getSearchReposOrder();
}

/// アプリデータのキー名
enum AppDataKey {
  /// リポジトリ検索用ソート値
  searchReposSort,

  /// リポジトリ検索用オーダー値
  searchReposOrder,
}
