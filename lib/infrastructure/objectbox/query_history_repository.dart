// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/query_history.dart';
import '../../domain/entities/query_history_input.dart';
import '../../domain/exceptions.dart';
import '../../domain/repositories/query_history_repository.dart';
import '../../objectbox.g.dart';
import '../../utils/extensions.dart';
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
    logger.v('queryString = ${input.queryString}');
    try {
      input.validate();
    } on ValidatorException catch (e) {
      logger.v(e);
      return;
    }
    final id = _box.put(
      QueryHistoryEntity(
        queryString: input.queryString.trim().toLowerCase(),
        searchedAt: DateTime.now(),
      ),
    );
    logger.v('Added query history: id = $id');
  }

  @override
  Future<void> delete(QueryHistory query) async {
    logger.v('queryString = ${query.queryString}');
    final results = _box
        .query(QueryHistoryEntity_.queryString.equals(query.queryString))
        .build()
        .find();
    final count = _box.removeMany(results.map((e) => e.id).toList());
    logger.v('Deleted query history: count = $count');
  }

  @override
  Future<List<QueryHistory>> findByQueryString(String queryString) async {
    logger.v('queryString = $queryString');

    final qBuilder = _box.query(
      QueryHistoryEntity_.queryString.startsWith(queryString.toLowerCase()),
    )..order(QueryHistoryEntity_.searchedAt, flags: Order.descending);
    final q = qBuilder.build();
    final qp = q.property(QueryHistoryEntity_.queryString)..distinct = true;
    final results = qp.find().sublistSafety(0, 20);
    q.close();

    final queries = results
        .map(
          (queryString) => QueryHistory(
            queryString: queryString,
          ),
        )
        .toList();
    logger.v('Find query histories: count = ${queries.length}');
    return queries;
  }
}
