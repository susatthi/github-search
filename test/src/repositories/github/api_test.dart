// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/repositories/github/api.dart';

void main() {
  late GithubApi api;
  setUp(() {
    api = const GithubApi();
  });

  group('searchRepos()', () {
    test('クエリパラメータが正しいはず', () {
      final uri = api.searchRepos(
        query: 'query',
        sort: GithubParamSearchReposSort.stars,
        order: GithubParamOrder.desc,
        perPage: 10,
        page: 2,
      );
      expect(uri.query, 'q=query&sort=stars&order=desc&per_page=10&page=2');
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
        ownerName: 'keyber-inc',
        repoName: 'github_search',
      );
      expect(uri.path, '/repos/keyber-inc/github_search');
    });
    test('ownerNameが空文字の場合はassertが発生するはず', () {
      expect(
        () {
          api.getRepo(
            ownerName: '',
            repoName: 'github_search',
          );
        },
        throwsAssertionError,
      );
    });
    test('repoNameが空文字の場合はassertが発生するはず', () {
      expect(
        () {
          api.getRepo(
            ownerName: 'keyber-inc',
            repoName: '',
          );
        },
        throwsAssertionError,
      );
    });
  });
}