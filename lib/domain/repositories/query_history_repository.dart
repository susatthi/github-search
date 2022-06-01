// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/query_history.dart';
import '../entities/query_history_input.dart';

/// 検索履歴Repositoryプロバイダー
final queryHistoryRepositoryProvider = Provider<QueryHistoryRepository>(
  (ref) => throw UnimplementedError(),
);

/// 検索履歴Repository
abstract class QueryHistoryRepository {
  /// 検索履歴を登録する
  Future<void> add(QueryHistoryInput input);

  /// 検索履歴を削除する
  Future<void> delete(QueryHistory query);

  /// 検索履歴一覧を検索する
  ///
  /// - 検索条件
  ///   - 大文字小文字を区別しない [queryString] から始まる
  /// - ソート
  ///   - 検索日時の降順
  /// - 検索件数
  ///   - 20件
  Future<List<QueryHistory>> findByQueryString(String queryString);
}
