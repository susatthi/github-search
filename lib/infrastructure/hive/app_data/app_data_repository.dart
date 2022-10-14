// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/repositories/app_data/app_data_repository.dart';
import '../../../domain/repositories/app_data/entities/app_data_key.dart';

/// Hive の Box 名
const hiveBoxNameAppData = 'appData';

/// Hive版アプリデータRepositoryプロバイダー
final hiveAppDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => HiveAppDataRepository(
    box: Hive.box<dynamic>(hiveBoxNameAppData),
  ),
);

/// Hive版アプリデータRepository
class HiveAppDataRepository implements AppDataRepository {
  const HiveAppDataRepository({
    required this.box,
  });

  /// Hive Box
  final Box<dynamic> box;

  @override
  void set<T extends Object?>(AppDataKey key, T value) {
    box.put(key.name, value);
  }

  @override
  T get<T extends Object?>(AppDataKey key) {
    return box.get(
      key.name,
      defaultValue: AppDataRepository.defaultValues[key] as T?,
    ) as T;
  }

  @override
  Stream<T> listen<T extends Object?>(AppDataKey key) {
    return box.watch(key: key.name).map<T>((event) => event.value as T);
  }
}
