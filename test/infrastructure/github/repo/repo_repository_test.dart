// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/exceptions.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_order.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_sort.dart';
import 'package:github_search/domain/repositories/repo/entities/values/repo_count.dart';
import 'package:github_search/domain/repositories/repo/entities/values/repo_language.dart';
import 'package:github_search/domain/repositories/repo/repo_repository.dart';
import 'package:github_search/infrastructure/github/repo/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../test_utils/test_agent.dart';
import '../../../test_utils/utils.dart';

void main() {
  final repo = GitHubRepoRepository.repoBuilder(
    RepoJsonObject.fromJson(
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
    ),
  );

  final agent = TestAgent();
  late RepoRepository repository;
  setUp(() async {
    await agent.setUp();
    repository = agent.mockContainer().read(githubRepoRepositoryProvider);
  });
  tearDown(agent.tearDown);

  group('GitHubRepoRepository', () {
    test('searchRepos() 検索できるはず', () async {
      final result = await repository.searchRepos(
        queryString: 'flutter',
        sort: SearchReposSort.bestMatch,
        order: SearchReposOrder.desc,
      );
      expect(result, isNotNull);
    });
    test('getRepo() 取得できるはず', () async {
      final repo = await repository.getRepo(
        ownerName: 'flutter',
        repoName: 'flutter',
      );
      expect(repo, isNotNull);
    });
    test('repoBuilder() 正しく変換できるはず', () async {
      expect(repo.language.value, 'Dart');
      expect(repo.language.display, 'Dart');
      expect(repo.language.color.value, HexColor('#00B4AB').value);
      expect(repo.stargazersCount.value, 137773);
      expect(repo.stargazersCount.display, '138k');
      expect(repo.watchersCount.value, 137773);
      expect(repo.watchersCount.display, '138k');
      expect(repo.forksCount.value, 21221);
      expect(repo.forksCount.display, '21k');
      expect(repo.openIssuesCount.value, 10623);
      expect(repo.openIssuesCount.display, '11k');
    });
    test('getReadme() 取得できるはず', () async {
      final content = await repository.getReadme(
        repo: repo,
      );
      expect(content, isNotNull);
    });
    test('getReadme() 不明なパラメータだと404で取得できないはず', () async {
      String? content;
      String? errorCode;
      try {
        content = await repository.getReadme(
          repo: repo.copyWith(
            ownerName: 'unknown',
            repoName: 'unknown',
            defaultBranch: 'unknown',
          ),
        );
      } on NetworkException catch (e) {
        errorCode = e.code;
      }
      expect(content, isNull);
      expect(errorCode, NetworkException.codeNotFound);
    });
    test('getReadme() 通信エラーだと取得できないはず', () async {
      String? content;
      String? errorCode;
      try {
        content = await repository.getReadme(
          repo: repo.copyWith(
            ownerName: 'unknown',
            repoName: 'unknown',
            defaultBranch: 'socketException',
          ),
        );
      } on NetworkException catch (e) {
        errorCode = e.code;
      }
      expect(content, isNull);
      expect(errorCode, NetworkException.codeNoInternetConnection);
    });
  });
}
