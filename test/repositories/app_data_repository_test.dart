// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/app_data_repository.dart';

import '../test_utils/mocks.dart';

void main() {
  late ProviderContainer container;
  setUp(() async {
    await openAppDataBox();
    container = ProviderContainer();
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
