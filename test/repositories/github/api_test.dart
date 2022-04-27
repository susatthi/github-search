// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/github/api.dart';
import 'package:github_search/repositories/repo_repository.dart';

void main() {
  late GitHubApi api;
  setUp(() {
    api = const GitHubApi();
  });

  group('searchRepos()', () {
    test('クエリパラメータが正しいはず1', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubParamSearchReposSort.stars,
        order: GitHubParamSearchReposOrder.desc,
        perPage: 10,
        page: 2,
      );
      expect(uri.query, 'q=query&sort=stars&order=desc&per_page=10&page=2');
    });
    test('クエリパラメータが正しいはず2', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubParamSearchReposSort.forks,
        order: GitHubParamSearchReposOrder.asc,
        perPage: 20,
        page: 3,
      );
      expect(uri.query, 'q=query&sort=forks&order=asc&per_page=20&page=3');
    });
    test('クエリパラメータが正しいはず3', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubParamSearchReposSort.helpWantedIssues,
        order: GitHubParamSearchReposOrder.asc,
        perPage: 20,
        page: 3,
      );
      expect(
        uri.query,
        'q=query&sort=help-wanted-issues&order=asc&per_page=20&page=3',
      );
    });
    test('クエリパラメータが正しいはず4', () {
      final uri = api.searchRepos(query: 'query');
      expect(uri.query, 'q=query');
    });
    test('検索文字列が空の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(query: '');
        },
        throwsAssertionError,
      );
    });
    test('perPageが0以下の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(query: 'query', perPage: 0);
        },
        throwsAssertionError,
      );
      expect(
        () {
          api.searchRepos(query: 'query', perPage: -1);
        },
        throwsAssertionError,
      );
    });
    test('perPageが101以上の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(query: 'query', perPage: 101);
        },
        throwsAssertionError,
      );
    });
    test('pageが0以下の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(query: 'query', page: 0);
        },
        throwsAssertionError,
      );
      expect(
        () {
          api.searchRepos(query: 'query', page: -1);
        },
        throwsAssertionError,
      );
    });
  });
  group('getRepo()', () {
    test('エンドポイントが正しいはず', () {
      final uri = api.getRepo(
        ownerName: 'susatthi',
        repoName: 'github-search',
      );
      expect(uri.path, '/repos/susatthi/github-search');
    });
    test('ownerNameが空文字の場合はassertが発生するはず', () {
      expect(
        () {
          api.getRepo(
            ownerName: '',
            repoName: 'github-search',
          );
        },
        throwsAssertionError,
      );
    });
    test('repoNameが空文字の場合はassertが発生するはず', () {
      expect(
        () {
          api.getRepo(
            ownerName: 'susatthi',
            repoName: '',
          );
        },
        throwsAssertionError,
      );
    });
  });
  group('GitHubParamSearchReposSortHelper', () {
    test('stars.name', () {
      expect(GitHubParamSearchReposSort.stars.name, 'stars');
    });
    test('stars.forks', () {
      expect(GitHubParamSearchReposSort.forks.name, 'forks');
    });
    test('stars.helpWantedIssues', () {
      expect(
        GitHubParamSearchReposSort.helpWantedIssues.name,
        'help-wanted-issues',
      );
    });
    test('valueOf(bestMatch)', () {
      expect(
        GitHubParamSearchReposSortHelper.valueOf(
          RepoParamSearchReposSort.bestMatch,
        ),
        null,
      );
    });
    test('valueOf(stars)', () {
      expect(
        GitHubParamSearchReposSortHelper.valueOf(
          RepoParamSearchReposSort.stars,
        ),
        GitHubParamSearchReposSort.stars,
      );
    });
    test('valueOf(forks)', () {
      expect(
        GitHubParamSearchReposSortHelper.valueOf(
          RepoParamSearchReposSort.forks,
        ),
        GitHubParamSearchReposSort.forks,
      );
    });
    test('valueOf(helpWantedIssues)', () {
      expect(
        GitHubParamSearchReposSortHelper.valueOf(
          RepoParamSearchReposSort.helpWantedIssues,
        ),
        GitHubParamSearchReposSort.helpWantedIssues,
      );
    });
  });
}
