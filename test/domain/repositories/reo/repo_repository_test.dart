// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/repo/repo_repository.dart';

import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('repoRepositoryProvider', () {
    test('DIする前はUnimplementedErrorがthrowされるはず', () async {
      expect(
        () => ProviderContainer().read(repoRepositoryProvider),
        throwsUnimplementedError,
      );
    });
    test('repoRepositoryProviderからGitHubRepoRepositoryが取得できるはず', () async {
      final repoRepository = agent.mockContainer().read(repoRepositoryProvider);
      expect(repoRepository.runtimeType.toString(), 'GitHubRepoRepository');
    });
  });
}
