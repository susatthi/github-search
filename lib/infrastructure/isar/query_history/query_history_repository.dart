// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../domain/repository/query_history/entity/query_history.dart';
import '../../../domain/repository/query_history/query_history_repository.dart';
import '../../../util/logger.dart';
import 'collection/query_history.dart';

/// Isarインスタンスプロバイダー
///
/// runApp()前に初期化したIsarインスタンスでoverrideすること
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// Isar版検索履歴Repositoryプロバイダー
final isarQueryHistoryRepositoryProvider = Provider<QueryHistoryRepository>(
  (ref) => IsarQueryHistoryRepository(
    isar: ref.watch(isarProvider),
  ),
);

/// Isar版検索履歴Repository
class IsarQueryHistoryRepository implements QueryHistoryRepository {
  IsarQueryHistoryRepository({
    required this.isar,
  });

  final Isar isar;

  @override
  Future<void> add(QueryHistory queryHistory) async {
    final queryString = queryHistory.queryString.value;
    logger.v('START TRANSACTION add(): queryString = $queryString');
    return isar.writeTxn(
      () async {
        final id = await isar.queryHistoryCollections.put(
          QueryHistoryCollection()
            ..queryString = queryString
            ..searchedAt = DateTime.now(),
        );
        final added = await isar.queryHistoryCollections.get(id);
        logger.v('END TRANSACTION add(): $added');
      },
    );
  }

  @override
  Future<void> delete(QueryHistory queryHistory) async {
    final queryString = queryHistory.queryString.value;
    logger.v(
      'START TRANSACTION delete(): queryString = $queryString',
    );
    return isar.writeTxn(
      () async {
        final count = await isar.queryHistoryCollections
            .filter()
            .queryStringEqualTo(queryString)
            .deleteAll();
        logger.v(
          'END TRANSACTION delete(): queryString = $queryString, '
          'count = $count',
        );
      },
    );
  }

  @override
  Future<List<QueryHistory>> finds({required String queryString}) async {
    final collections = await _queryBuilder(queryString: queryString).findAll();

    final queries = collections
        .map(
          (collection) => QueryHistory.create(collection.queryString),
        )
        .toList();

    logger.v(
      'finds(): queryString = ${queryString.trim()}, '
      'count = ${queries.length}',
    );
    return queries;
  }

  @override
  Stream<List<QueryHistory>> changes({required String queryString}) {
    logger.v('changes(): queryString = ${queryString.trim()}');
    return _queryBuilder(queryString: queryString).watch().map(
          (collections) => collections
              .map((collection) => QueryHistory.create(collection.queryString))
              .toList(),
        );
  }

  /// 検索結果のクエリービルダーを帰す
  QueryBuilder<QueryHistoryCollection, QueryHistoryCollection, QAfterLimit>
      _queryBuilder({
    required String queryString,
  }) =>
          isar.queryHistoryCollections
              .filter()
              .queryStringStartsWith(queryString.trim(), caseSensitive: false)
              .sortBySearchedAtDesc()
              .distinctByQueryString()
              .limit(20);
}
