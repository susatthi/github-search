// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/query_history/query_history_repository.dart';

import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('queryHistoryRepositoryProvider', () {
    test('DIする前はUnimplementedErrorがthrowされるはず', () async {
      expect(
        () => ProviderContainer().read(queryHistoryRepositoryProvider),
        throwsUnimplementedError,
      );
    });
    test('queryHistoryRepositoryProviderからIsarQueryHistoryRepositoryが取得できるはず',
        () async {
      final queryHistoryRepository =
          agent.mockContainer().read(queryHistoryRepositoryProvider);
      expect(
        queryHistoryRepository.runtimeType.toString(),
        'IsarQueryHistoryRepository',
      );
    });
  });
}
