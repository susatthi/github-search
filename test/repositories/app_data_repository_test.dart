// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/app_data_repository.dart';
import 'package:github_search/repositories/hive/app_data_repository.dart';
import 'package:hive/hive.dart';

import '../test_utils/mocks.dart';

void main() {
  late ProviderContainer container;
  late Box<dynamic> appDataBox;
  setUp(() async {
    appDataBox = await openAppDataBox();
    container = ProviderContainer(
      overrides: [
        // モック版のHiveBoxを使う
        appDataBoxProvider.overrideWithValue(appDataBox),
      ],
    );
  });

  tearDown(() async {
    await closeAppDataBox();
  });

  group('appDataRepositoryProvider', () {
    test('appDataRepositoryProviderからHiveAppDataRepositoryが取得できるはず', () async {
      final appDataRepository = container.read(appDataRepositoryProvider);
      expect(appDataRepository.runtimeType.toString(), 'HiveAppDataRepository');
    });
  });
}
