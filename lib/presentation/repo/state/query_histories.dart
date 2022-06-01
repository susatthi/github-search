// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/query_history.dart';
import '../../../domain/repositories/query_history_repository.dart';
import 'search_repos_query.dart';

/// 検索履歴一覧プロバイダー
final queryHistoriesProvider = StateNotifierProvider.autoDispose<
    QueryHistoriesNotifier, AsyncValue<List<QueryHistory>>>(
  (ref) => QueryHistoriesNotifier(
    ref.read,
    queryString: ref.watch(repoSearchReposEnteringQueryStringProvider),
  ),
);

/// 検索履歴一覧Notifier
class QueryHistoriesNotifier
    extends StateNotifier<AsyncValue<List<QueryHistory>>> {
  QueryHistoriesNotifier(
    this._read, {
    required this.queryString,
  }) : super(const AsyncValue.loading()) {
    _load();
  }

  final Reader _read;

  /// 検索文字列
  final String queryString;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _read(queryHistoryRepositoryProvider)
          .findByQueryString(queryString);
    });
  }

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory query) async {
    await _read(queryHistoryRepositoryProvider).delete(query);
    await _load();
  }
}
