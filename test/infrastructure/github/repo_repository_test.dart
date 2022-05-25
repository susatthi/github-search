// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repo/repositories/repo_repository.dart';
import 'package:github_search/infrastructure/github/exception.dart';
import 'package:github_search/infrastructure/github/repo_repository.dart';

import '../../test_utils/locale.dart';
import '../../test_utils/mocks.dart';

void main() {
  late GitHubRepoRepository repository;
  setUp(() {
    repository = mockProviderContainer().read(githubRepoRepositoryProvider);
    useEnvironmentLocale();
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
  group('GitHubRepoRepository.getReadme()', () {
    test('取得できるはず', () async {
      final content = await repository.getReadme(
        ownerName: 'flutter',
        repoName: 'flutter',
        defaultBranch: 'master',
      );
      expect(content, isNotNull);
    });
    test('404で取得できないはず', () async {
      String? content;
      String? errorCode;
      try {
        content = await repository.getReadme(
          ownerName: 'unknown',
          repoName: 'unknown',
          defaultBranch: 'unknown',
        );
      } on GitHubException catch (e) {
        errorCode = e.code;
      }
      expect(content, isNull);
      expect(errorCode, GitHubException.codeNotFound);
    });
    test('通信エラーで取得できないはず', () async {
      String? content;
      String? errorCode;
      try {
        content = await repository.getReadme(
          ownerName: 'unknown',
          repoName: 'unknown',
          defaultBranch: 'socketException',
        );
      } on GitHubException catch (e) {
        errorCode = e.code;
      }
      expect(content, isNull);
      expect(errorCode, GitHubException.codeNoInternetConnection);
    });
  });
}
