// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/search_repos_sort.dart';
import '../../../domain/repositories/app_data_repository.dart';

/// リポジトリ検索用ソート値プロバイダー
final repoSearchReposSortProvider = StateProvider<SearchReposSort>(
  (ref) {
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return appDataRepository.getSearchReposSort();
  },
);

/// リポジトリ検索用ソート値更新メソッドプロバイダー
final repoSearchReposSortUpdaterProvider = Provider(
  (ref) {
    final notifier = ref.read(repoSearchReposSortProvider.notifier);
    final appDataRepository = ref.watch(appDataRepositoryProvider);
    return (SearchReposSort sort) {
      appDataRepository.setSearchReposSort(sort);
      notifier.state = appDataRepository.getSearchReposSort();
    };
  },
);
