// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/query_history.dart';
import '../../domain/entities/query_history_input.dart';
import '../../domain/exceptions.dart';
import '../../domain/repositories/query_history_repository.dart';
import '../../utils/logger.dart';
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

    return _isar.writeTxn(
      (isar) => isar.queryHistoryCollections.put(
        QueryHistoryCollection()
          ..queryString = input.queryString
          ..searchedAt = DateTime.now(),
      ),
    );
  }

  @override
  Future<void> delete(QueryHistory query) async {
    return _isar.writeTxn(
      (isar) => _isar.queryHistoryCollections
          .filter()
          .queryStringEqualTo(query.queryString)
          .deleteAll(),
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
    return collections
        .map(
          (collection) => QueryHistory(
            queryString: collection.queryString,
          ),
        )
        .toList();
  }
}
