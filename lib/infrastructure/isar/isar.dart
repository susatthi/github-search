// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:isar/isar.dart';

import 'query_history/collection/query_history.dart';

/// Isar を初期化する
Future<Isar> initIsar({required String directory}) async {
  return Isar.open(
    [
      QueryHistoryCollectionSchema,
    ],
    directory: directory,
  );
}
