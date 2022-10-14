import 'package:isar/isar.dart';

import 'query_history/collections/query_history.dart';

/// Isar を初期化する
Future<Isar> initIsar({required String directory}) async {
  return Isar.open(
    [
      QueryHistoryCollectionSchema,
    ],
    directory: directory,
  );
}
