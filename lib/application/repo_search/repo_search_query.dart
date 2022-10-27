// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/search_repos_query.dart';
import '../../domain/repository/query_history/entity/query_history.dart';
import '../../domain/repository/query_history/query_history_repository.dart';

/// リポジトリ検索履歴一覧プロバイダー
final queryHistoriesProvider = FutureProvider.autoDispose<List<QueryHistory>>(
  (ref) {
    final enteringQueryString = ref.watch(searchReposEnteringQueryProvider);
    return ref.watch(queryHistoriesProviderFamily(enteringQueryString).future);
  },
  name: 'queryHistoriesProvider',
);
