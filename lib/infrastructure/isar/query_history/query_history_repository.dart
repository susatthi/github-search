// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../domain/exceptions.dart';
import '../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../domain/repositories/query_history/entities/query_history_input.dart';
import '../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../utils/logger.dart';
import 'collections/query_history.dart';

/// Isarインスタンスプロバイダー
///
/// runApp()前に初期化したIsarインスタンスでoverrideすること
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError(),
);

/// Isar版検索履歴Repositoryプロバイダー
final isarQueryHistoryRepositoryProvider = Provider<QueryHistoryRepository>(
  (ref) => IsarQueryHistoryRepository(ref.read),
);

/// Isar版検索履歴Repository
class IsarQueryHistoryRepository implements QueryHistoryRepository {
  IsarQueryHistoryRepository(
    Reader read,
  ) : _isar = read(isarProvider);

  final Isar _isar;

  @override
  Future<void> add(QueryHistoryInput input) async {
    try {
      input.validate();
    } on ValidatorException catch (e) {
      logger.v(e);
      return;
    }

    final queryString = input.queryString.trim();
    logger.v('START TRANSACTION add(): queryString = $queryString');
    return _isar.writeTxn(
      (isar) async {
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
  Future<void> delete(QueryHistory query) async {
    logger.v('START TRANSACTION delete(): queryString = ${query.queryString}');
    return _isar.writeTxn(
      (isar) async {
        final count = await _isar.queryHistoryCollections
            .filter()
            .queryStringEqualTo(query.queryString)
            .deleteAll();
        logger.v(
          'END TRANSACTION delete(): queryString = ${query.queryString}, '
          'count = $count',
        );
      },
    );
  }

  @override
  Future<List<QueryHistory>> findByQueryString(String queryString) async {
    final collections = await _isar.queryHistoryCollections
        .filter()
        .queryStringStartsWith(queryString, caseSensitive: false)
        .sortBySearchedAtDesc()
        .distinctByQueryString()
        .limit(20)
        .findAll();

    final queries = collections
        .map(
          (collection) => QueryHistory(
            queryString: collection.queryString,
          ),
        )
        .toList();

    logger.v(
      'findByQueryString(): queryString = $queryString, '
      'count = ${queries.length}',
    );
    return queries;
  }
}
