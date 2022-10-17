// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../utils/logger.dart';
import 'collections/query_history.dart';

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
    final collections = await isar.queryHistoryCollections
        .filter()
        .queryStringStartsWith(queryString.trim(), caseSensitive: false)
        .sortBySearchedAtDesc()
        .distinctByQueryString()
        .limit(20)
        .findAll();

    final queries = collections
        .map(
          (collection) => QueryHistory.create(collection.queryString),
        )
        .toList();

    logger.v(
      'findByQueryString(): queryString = ${queryString.trim()}, '
      'count = ${queries.length}',
    );
    return queries;
  }
}
