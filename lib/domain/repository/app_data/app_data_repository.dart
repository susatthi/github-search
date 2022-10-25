// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entity/app_data_key.dart';

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// 値を設定する
  void set<T extends Object?>(AppDataKey key, T value);

  /// 値を返す
  T get<T extends Object?>(AppDataKey key);

  /// Stream を返す
  Stream<T> changes<T extends Object?>(AppDataKey key);
}
