// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/app_data/app_data_repository.dart';

import '../../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('appDataRepositoryProvider', () {
    test('DIする前はUnimplementedErrorがthrowされるはず', () async {
      expect(
        () => ProviderContainer().read(appDataRepositoryProvider),
        throwsUnimplementedError,
      );
    });
    test('appDataRepositoryProviderからHiveAppDataRepositoryが取得できるはず', () async {
      final appDataRepository =
          agent.mockContainer().read(appDataRepositoryProvider);
      expect(appDataRepository.runtimeType.toString(), 'HiveAppDataRepository');
    });
  });
}
