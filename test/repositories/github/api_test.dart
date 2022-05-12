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

  group('GitHubApi.searchRepos()', () {
    test('クエリパラメータが正しいはず1', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubRepoSearchReposSort.stars,
        order: GitHubRepoSearchReposOrder.desc,
        perPage: 10,
        page: 2,
      );
      expect(uri.query, 'q=query&sort=stars&order=desc&per_page=10&page=2');
    });
    test('クエリパラメータが正しいはず2', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubRepoSearchReposSort.forks,
        order: GitHubRepoSearchReposOrder.asc,
        perPage: 20,
        page: 3,
      );
      expect(uri.query, 'q=query&sort=forks&order=asc&per_page=20&page=3');
    });
    test('クエリパラメータが正しいはず3', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GitHubRepoSearchReposSort.helpWantedIssues,
        order: GitHubRepoSearchReposOrder.asc,
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
  group('GitHubApi.getRepo()', () {
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
  group('GitHubRepoSearchReposSort', () {
    test('stars.name', () {
      expect(GitHubRepoSearchReposSort.stars.name, 'stars');
    });
    test('forks.name', () {
      expect(GitHubRepoSearchReposSort.forks.name, 'forks');
    });
    test('helpWantedIssues.name', () {
      expect(
        GitHubRepoSearchReposSort.helpWantedIssues.name,
        'help-wanted-issues',
      );
    });
    test('valueOf(bestMatch)', () {
      expect(
        GitHubRepoSearchReposSort.valueOf(
          RepoSearchReposSort.bestMatch,
        ),
        null,
      );
    });
    test('valueOf(stars)', () {
      expect(
        GitHubRepoSearchReposSort.valueOf(
          RepoSearchReposSort.stars,
        ),
        GitHubRepoSearchReposSort.stars,
      );
    });
    test('valueOf(forks)', () {
      expect(
        GitHubRepoSearchReposSort.valueOf(
          RepoSearchReposSort.forks,
        ),
        GitHubRepoSearchReposSort.forks,
      );
    });
    test('valueOf(helpWantedIssues)', () {
      expect(
        GitHubRepoSearchReposSort.valueOf(
          RepoSearchReposSort.helpWantedIssues,
        ),
        GitHubRepoSearchReposSort.helpWantedIssues,
      );
    });
  });
  group('GitHubRepoSearchReposOrder', () {
    test('desc.name', () {
      expect(GitHubRepoSearchReposOrder.desc.name, 'desc');
    });
    test('asc.name', () {
      expect(GitHubRepoSearchReposOrder.asc.name, 'asc');
    });
    test('valueOf(desc)', () {
      expect(
        GitHubRepoSearchReposOrder.valueOf(
          RepoSearchReposOrder.desc,
        ),
        GitHubRepoSearchReposOrder.desc,
      );
    });
    test('valueOf(asc)', () {
      expect(
        GitHubRepoSearchReposOrder.valueOf(
          RepoSearchReposOrder.asc,
        ),
        GitHubRepoSearchReposOrder.asc,
      );
    });
  });
}
