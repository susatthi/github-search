// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/repositories/github/api.dart';
import 'package:github_search/src/repositories/github/repo_repository.dart';

import '../../../mocks/mocks.dart';

void main() {
  late GithubRepoRepository repository;
  setUp(() {
    repository = GithubRepoRepository(
      api: const GithubApi(),
      client: mockGithubHttpClient,
    );
  });

  group('searchRepos()', () {
    test('検索できるはず', () async {
      final result = await repository.searchRepos(query: 'flutter');
      expect(result, isNotNull);
    });
  });
  group('getRepo()', () {
    test('取得できるはず', () async {
      final repo = await repository.getRepo(
        ownerName: 'flutter',
        repoName: 'flutter',
      );
      expect(repo, isNotNull);
    });
  });
}
