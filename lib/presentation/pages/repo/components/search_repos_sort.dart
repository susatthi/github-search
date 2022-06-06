// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/app_data/app_data_repository.dart';
import '../../../../domain/repositories/repo/entities/search_repos_sort.dart';

/// リポジトリ検索用ソート値プロバイダー
final searchReposSortProvider = StateProvider<SearchReposSort>(
  (ref) {
    final appDataRepository = ref.read(appDataRepositoryProvider);
    return appDataRepository.getSearchReposSort();
  },
);

/// リポジトリ検索用ソート値更新メソッドプロバイダー
final searchReposSortUpdater = Provider(
  (ref) {
    final notifier = ref.read(searchReposSortProvider.notifier);
    final appDataRepository = ref.read(appDataRepositoryProvider);
    return (SearchReposSort sort) {
      appDataRepository.setSearchReposSort(sort);
      notifier.state = appDataRepository.getSearchReposSort();
    };
  },
);
