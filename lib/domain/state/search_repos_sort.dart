// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/app_data/app_data_repository.dart';
import '../repository/app_data/entity/app_data_key.dart';
import '../repository/repo/entity/search_repos_sort.dart';
import 'app_data_controller.dart';

/// リポジトリ検索用ソート値プロバイダー
final searchReposSortStateProvider =
    StateNotifierProvider<SearchReposSortStateController, SearchReposSort>(
  (ref) => SearchReposSortStateController(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposSortProvider',
);

/// リポジトリ検索用ソート値コントローラー
class SearchReposSortStateController
    extends AppDataController<SearchReposSort> {
  SearchReposSortStateController({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposSort);
}
