// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import 'search_repos_query.dart';

/// 検索履歴一覧プロバイダー
final queryHistoriesProvider = FutureProvider.autoDispose<List<QueryHistory>>(
  (ref) {
    final enteringQueryString = ref.watch(searchReposEnteringQueryProvider);
    ref.listen(
      queryHistoriesStreamProviderFamily(enteringQueryString),
      (previous, next) {
        ref.state = next;
      },
    );
    return ref
        .watch(queryHistoriesFutureProviderFamily(enteringQueryString).future);
  },
  name: 'queryHistoriesProvider',
);

// 検索履歴一覧コントローラープロバイダー
final queryHistoriesControllerProvider = Provider<QueryHistoriesController>(
  (ref) => QueryHistoriesController(
    queryHistoryRepository: ref.watch(queryHistoryRepositoryProvider),
  ),
);

/// 検索履歴一覧コントローラー
class QueryHistoriesController {
  QueryHistoriesController({
    required this.queryHistoryRepository,
  });

  final QueryHistoryRepository queryHistoryRepository;

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory queryHistory) async {
    await queryHistoryRepository.delete(queryHistory);
  }
}
