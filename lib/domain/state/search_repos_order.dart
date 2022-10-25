// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/app_data/app_data_repository.dart';
import '../repository/app_data/entity/app_data_key.dart';
import '../repository/repo/entity/search_repos_order.dart';
import 'app_data_controller.dart';

/// リポジトリ検索用オーダー値プロバイダー
final searchReposOrderStateProvider =
    StateNotifierProvider<SearchReposOrderStateController, SearchReposOrder>(
  (ref) => SearchReposOrderStateController(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposOrderProvider',
);

/// リポジトリ検索用オーダー値コントローラー
class SearchReposOrderStateController
    extends AppDataController<SearchReposOrder> {
  SearchReposOrderStateController({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposOrder);
}
