// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/logger.dart';
import 'search_repos_query.dart';

/// 検索履歴一覧プロバイダー
final queryHistoriesProvider = StateNotifierProvider.autoDispose<
    QueryHistoriesNotifier, AsyncValue<List<QueryHistory>>>(
  (ref) {
    final notifier = QueryHistoriesNotifier(
      ref.read,
      queryString: ref.watch(repoSearchReposEnteringQueryStringProvider),
    );
    ref.onDispose(() {
      logger.v('Disposed notifier: $notifier');
    });
    logger.v('Created notifier: $notifier');
    return notifier;
  },
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
    final asyncValue = await AsyncValue.guard(() async {
      return _read(queryHistoryRepositoryProvider)
          .findByQueryString(queryString);
    });
    if (mounted) {
      // 検索文字列を高速で入力されると、検索履歴を検索中に本Notifierが破棄されること
      // があるので、破棄されていないかをチェックする必要がある
      state = asyncValue;
      if (asyncValue is AsyncData) {
        logger.v('Updated state: queries.length = ${asyncValue.value!.length}');
      } else if (asyncValue is AsyncError) {
        logger.v(
          'Updated state: asyncError = ${asyncValue.asError?.error.toString()}',
        );
      }
    } else {
      logger.v(
        'Unmounted state: asyncValue = $asyncValue',
      );
    }
  }

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory query) async {
    state = const AsyncValue.loading();
    await _read(queryHistoryRepositoryProvider).delete(query);
    await _load();
  }

  @override
  String toString() => '{queryString: $queryString, hashCode: $hashCode}';
}
