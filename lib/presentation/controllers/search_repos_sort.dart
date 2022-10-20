// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/app_data/app_data_repository.dart';
import '../../../../domain/repositories/app_data/entities/app_data_key.dart';
import '../../../../domain/repositories/repo/entities/search_repos_sort.dart';
import 'app_data.dart';

/// リポジトリ検索用ソート値プロバイダー
final searchReposSortProvider =
    StateNotifierProvider<SearchReposSortController, SearchReposSort>(
  (ref) => SearchReposSortController(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposSortProvider',
);

/// リポジトリ検索用ソート値コントローラー
class SearchReposSortController extends AppDataController<SearchReposSort> {
  SearchReposSortController({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposSort);
}
