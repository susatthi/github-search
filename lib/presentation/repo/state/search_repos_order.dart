// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/search_repos_order.dart';
import '../../../domain/repositories/app_data_repository.dart';

/// リポジトリ検索用オーダー値プロバイダー
final repoSearchReposOrderProvider =
    StateNotifierProvider<RepoSearchReposOrderNotifier, SearchReposOrder>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return RepoSearchReposOrderNotifier(
      appDataRepository,
    );
  },
);

/// リポジトリ検索用オーダー値Notifier
class RepoSearchReposOrderNotifier extends StateNotifier<SearchReposOrder> {
  RepoSearchReposOrderNotifier(
    this._appDataRepository,
  ) : super(_appDataRepository.getSearchReposOrder());

  final AppDataRepository _appDataRepository;

  /// オーダー値を更新する
  // ignore: avoid_setters_without_getters
  set order(SearchReposOrder order) {
    _appDataRepository.setSearchReposOrder(order);
    state = _appDataRepository.getSearchReposOrder();
  }
}
