// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/search_repos_order.dart';
import 'package:github_search/domain/entities/search_repos_sort.dart';
import 'package:github_search/infrastructure/github/api.dart';

import '../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  const api = GitHubApi();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('GitHubApi.searchRepos()', () {
    test('クエリパラメータが正しいはず1', () {
      final uri = api.searchRepos(
        queryString: 'query',
        sort: GitHubSearchReposSort.stars,
        order: GitHubSearchReposOrder.desc,
        perPage: 10,
        page: 2,
      );
      expect(uri.query, 'q=query&sort=stars&order=desc&per_page=10&page=2');
    });
    test('クエリパラメータが正しいはず2', () {
      final uri = api.searchRepos(
        queryString: 'query',
        sort: GitHubSearchReposSort.forks,
        order: GitHubSearchReposOrder.asc,
        perPage: 20,
        page: 3,
      );
      expect(uri.query, 'q=query&sort=forks&order=asc&per_page=20&page=3');
    });
    test('クエリパラメータが正しいはず3', () {
      final uri = api.searchRepos(
        queryString: 'query',
        sort: GitHubSearchReposSort.helpWantedIssues,
        order: GitHubSearchReposOrder.asc,
        perPage: 20,
        page: 3,
      );
      expect(
        uri.query,
        'q=query&sort=help-wanted-issues&order=asc&per_page=20&page=3',
      );
    });
    test('クエリパラメータが正しいはず4', () {
      final uri = api.searchRepos(queryString: 'query');
      expect(uri.query, 'q=query');
    });
    test('検索文字列が空の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(queryString: '');
        },
        throwsAssertionError,
      );
    });
    test('perPageが0以下の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(queryString: 'query', perPage: 0);
        },
        throwsAssertionError,
      );
      expect(
        () {
          api.searchRepos(queryString: 'query', perPage: -1);
        },
        throwsAssertionError,
      );
    });
    test('perPageが101以上の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(queryString: 'query', perPage: 101);
        },
        throwsAssertionError,
      );
    });
    test('pageが0以下の場合はassertが発生するはず', () {
      expect(
        () {
          api.searchRepos(queryString: 'query', page: 0);
        },
        throwsAssertionError,
      );
      expect(
        () {
          api.searchRepos(queryString: 'query', page: -1);
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
  group('GitHubSearchReposSort', () {
    test('toString()', () {
      expect(
        GitHubSearchReposSort.stars.toString(),
        'GitHubSearchReposSort.stars',
      );
      expect(
        GitHubSearchReposSort.forks.toString(),
        'GitHubSearchReposSort.forks',
      );
      expect(
        GitHubSearchReposSort.helpWantedIssues.toString(),
        'GitHubSearchReposSort.helpWantedIssues',
      );
    });
    test('jsonName', () {
      expect(GitHubSearchReposSort.stars.jsonName, 'stars');
      expect(GitHubSearchReposSort.forks.jsonName, 'forks');
      expect(
        GitHubSearchReposSort.helpWantedIssues.jsonName,
        'help-wanted-issues',
      );
    });
    test('valueOf()', () {
      expect(
        GitHubSearchReposSort.valueOf(
          SearchReposSort.bestMatch,
        ),
        null,
      );
      expect(
        GitHubSearchReposSort.valueOf(
          SearchReposSort.stars,
        ),
        GitHubSearchReposSort.stars,
      );
      expect(
        GitHubSearchReposSort.valueOf(
          SearchReposSort.forks,
        ),
        GitHubSearchReposSort.forks,
      );
      expect(
        GitHubSearchReposSort.valueOf(
          SearchReposSort.helpWantedIssues,
        ),
        GitHubSearchReposSort.helpWantedIssues,
      );
    });
  });
  group('GitHubSearchReposOrder', () {
    test('toString()', () {
      expect(
        GitHubSearchReposOrder.desc.toString(),
        'GitHubSearchReposOrder.desc',
      );
      expect(
        GitHubSearchReposOrder.asc.toString(),
        'GitHubSearchReposOrder.asc',
      );
    });
    test('jsonName', () {
      expect(GitHubSearchReposOrder.asc.jsonName, 'asc');
      expect(GitHubSearchReposOrder.desc.jsonName, 'desc');
    });
    test('valueOf()', () {
      expect(
        GitHubSearchReposOrder.valueOf(
          SearchReposOrder.desc,
        ),
        GitHubSearchReposOrder.desc,
      );
      expect(
        GitHubSearchReposOrder.valueOf(
          SearchReposOrder.asc,
        ),
        GitHubSearchReposOrder.asc,
      );
    });
  });
}
