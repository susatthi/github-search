// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/github/repo_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';

import '../../test_utils/mocks.dart';

void main() {
  late GitHubRepoRepository repository;
  setUp(() {
    repository = mockProviderContainer().read(githubRepoRepositoryProvider);
  });

  group('GitHubRepoRepository.searchRepos()', () {
    test('検索できるはず', () async {
      final result = await repository.searchRepos(
        query: 'flutter',
        sort: RepoSearchReposSort.bestMatch,
        order: RepoSearchReposOrder.desc,
      );
      expect(result, isNotNull);
    });
  });
  group('GitHubRepoRepository.getRepo()', () {
    test('取得できるはず', () async {
      final repo = await repository.getRepo(
        ownerName: 'flutter',
        repoName: 'flutter',
      );
      expect(repo, isNotNull);
    });
  });
}
