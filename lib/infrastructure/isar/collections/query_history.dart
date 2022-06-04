// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:isar/isar.dart';

part 'query_history.g.dart';

@Collection()
class QueryHistoryCollection {
  int id = Isar.autoIncrement;

  /// 検索文字列
  late String queryString;

  /// 検索日時
  @Index()
  late DateTime searchedAt;

  @override
  String toString() =>
      '{id: $id, queryString: $queryString, searchedAt: $searchedAt}';
}
