// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/app_data/app_data_repository.dart';
import '../../../../domain/repositories/app_data/entities/app_data_key.dart';
import '../../../../domain/repositories/repo/entities/search_repos_order.dart';
import 'app_data.dart';

/// リポジトリ検索用オーダー値プロバイダー
final searchReposOrderProvider =
    StateNotifierProvider<SearchReposOrderController, SearchReposOrder>(
  (ref) => SearchReposOrderController(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposOrderProvider',
);

/// リポジトリ検索用オーダー値コントローラー
class SearchReposOrderController extends AppDataController<SearchReposOrder> {
  SearchReposOrderController({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposOrder);
}
