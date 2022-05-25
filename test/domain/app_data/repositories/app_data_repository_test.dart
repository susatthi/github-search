// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/app_data_repository.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  late ProviderContainer container;
  setUp(() async {
    tmpDir = await openAppDataBox();
    container = mockProviderContainer();
    useEnvironmentLocale();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('appDataRepositoryProvider', () {
    test('appDataRepositoryProviderからHiveAppDataRepositoryが取得できるはず', () async {
      final appDataRepository = container.read(appDataRepositoryProvider);
      expect(appDataRepository.runtimeType.toString(), 'HiveAppDataRepository');
    });
  });
}
