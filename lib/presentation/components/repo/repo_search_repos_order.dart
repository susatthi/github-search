// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/app_data_repository.dart';
import '../../../repositories/repo_repository.dart';

/// リポジトリ検索用オーダー値プロバイダー
final repoSearchReposOrderProvider =
    StateNotifierProvider<RepoSearchReposOrderController, RepoSearchReposOrder>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return RepoSearchReposOrderController(
      appDataRepository,
    );
  },
);

/// リポジトリ検索用オーダー値コントローラー
class RepoSearchReposOrderController
    extends StateNotifier<RepoSearchReposOrder> {
  RepoSearchReposOrderController(
    this._appDataRepository,
  ) : super(_appDataRepository.getSearchReposOrder());

  final AppDataRepository _appDataRepository;

  /// オーダー値を更新する
  // ignore: avoid_setters_without_getters
  set order(RepoSearchReposOrder order) {
    _appDataRepository.setSearchReposOrder(order);
    state = _appDataRepository.getSearchReposOrder();
  }
}
