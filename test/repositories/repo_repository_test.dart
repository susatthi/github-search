// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/repo_repository.dart';

import '../test_utils/mocks.dart';

void main() {
  late ProviderContainer container;
  setUp(() async {
    container = mockProviderContainer();
  });

  group('repoRepositoryProvider', () {
    test('repoRepositoryProviderからGitHubRepoRepositoryが取得できるはず', () async {
      final repoRepository = container.read(repoRepositoryProvider);
      expect(repoRepository.runtimeType.toString(), 'GitHubRepoRepository');
    });
  });
  group('RepoSearchReposSort', () {
    test('valueOf()でenum値が取れるはず', () async {
      expect(
        RepoSearchReposSort.valueOf(
          RepoSearchReposSort.bestMatch.name,
        ),
        RepoSearchReposSort.bestMatch,
      );
    });
    test('valueOf()でExceptionがthrowされるはず', () async {
      expect(
        () {
          RepoSearchReposSort.valueOf(
            'unknown value',
          );
        },
        throwsStateError,
      );
    });
  });
  group('RepoSearchReposOrder', () {
    test('valueOf()でenum値が取れるはず', () async {
      expect(
        RepoSearchReposOrder.valueOf(
          RepoSearchReposOrder.asc.name,
        ),
        RepoSearchReposOrder.asc,
      );
    });
    test('valueOf()でExceptionがthrowされるはず', () async {
      expect(
        () {
          RepoSearchReposOrder.valueOf(
            'unknown value',
          );
        },
        throwsStateError,
      );
    });
  });
}
