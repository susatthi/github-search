// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/query_history.dart';
import '../../domain/entities/query_history_input.dart';
import '../../domain/exceptions.dart';
import '../../domain/repositories/query_history_repository.dart';
import '../../objectbox.g.dart';
import '../../utils/logger.dart';
import 'entities/query_history.dart';

/// Storeインスタンスプロバイダー
///
/// runApp()前に初期化したStoreインスタンスでoverrideすること
final storeProvider = Provider<Store>(
  (ref) => throw UnimplementedError(),
);

/// Objectbox版検索履歴Repositoryプロバイダー
final objectboxQueryHistoryRepositoryProvider =
    Provider<QueryHistoryRepository>(
  (ref) => ObjectboxQueryHistoryRepository(ref.read),
);

/// Objectbox版検索履歴Repository
class ObjectboxQueryHistoryRepository implements QueryHistoryRepository {
  ObjectboxQueryHistoryRepository(
    Reader read,
  ) : _box = read(storeProvider).box<QueryHistoryEntity>();

  final Box<QueryHistoryEntity> _box;

  @override
  Future<void> add(QueryHistoryInput input) async {
    try {
      input.validate();
    } on ValidatorException catch (e) {
      logger.v(e);
      return;
    }

    final queryString = input.queryString.trim();
    final results = _box
        .query(QueryHistoryEntity_.queryString.equals(queryString))
        .build()
        .find();
    if (results.isEmpty) {
      final id = _box.put(
        QueryHistoryEntity(
          queryString: queryString,
          searchedAt: DateTime.now(),
        ),
      );
      final added = _box.get(id);
      logger.v('Added query history: $added');
    } else {
      final updated = results.first..searchedAt = DateTime.now();
      _box.put(updated);
      logger.v('Updated query history: $updated');
    }
  }

  @override
  Future<void> delete(QueryHistory query) async {
    final results = _box
        .query(QueryHistoryEntity_.queryString.equals(query.queryString))
        .build()
        .find();
    final count = _box.removeMany(results.map((e) => e.id).toList());
    logger.v(
      'Deleted query history: queryString = ${query.queryString}, '
      'count = $count',
    );
  }

  @override
  Future<List<QueryHistory>> findByQueryString(String queryString) async {
    final qBuilder = _box.query(
      QueryHistoryEntity_.queryString.startsWith(
        queryString.trim(),
        caseSensitive: false,
      ),
    )..order(QueryHistoryEntity_.searchedAt, flags: Order.descending);
    final q = qBuilder.build()..limit = 20;
    final results = q.find();
    q.close();

    final queries = results
        .map(
          (result) => QueryHistory(
            queryString: result.queryString,
          ),
        )
        .toList();
    logger.v(
      'Find query histories: queryString = $queryString, '
      'count = ${queries.length}',
    );
    return queries;
  }
}
