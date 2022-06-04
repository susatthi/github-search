// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:objectbox/objectbox.dart';

@Entity()
class QueryHistoryEntity {
  QueryHistoryEntity({
    required this.queryString,
    required this.searchedAt,
  });

  int id = 0;

  /// 検索文字列
  late String queryString;

  /// 検索日時
  @Property(type: PropertyType.dateNano)
  late DateTime searchedAt;

  @override
  String toString() =>
      '{id: $id, queryString: $queryString, searchedAt: $searchedAt}';
}
