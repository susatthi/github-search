// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_sort.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_sort.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('repoSearchReposSortProvider', () {
    test('初期値はベストマッチのはず', () async {
      final sort = agent.mockContainer().read(repoSearchReposSortProvider);
      expect(sort, SearchReposSort.bestMatch);
    });
  });
  group('repoSearchReposSortUpdater', () {
    test('ソート値を変更できるはず', () async {
      final updater = agent.mockContainer().read(repoSearchReposSortUpdater);

      // スター数に変更する
      updater(SearchReposSort.stars);

      // スター数のはず
      expect(
        agent.mockContainer().read(repoSearchReposSortProvider),
        SearchReposSort.stars,
      );

      // フォーク数に変更する
      updater(SearchReposSort.forks);

      // フォーク数のはず
      expect(
        agent.mockContainer().read(repoSearchReposSortProvider),
        SearchReposSort.forks,
      );

      // ヘルプ数に変更する
      updater(SearchReposSort.helpWantedIssues);

      // ヘルプ数のはず
      expect(
        agent.mockContainer().read(repoSearchReposSortProvider),
        SearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      updater(SearchReposSort.bestMatch);

      // ベストマッチのはず
      expect(
        agent.mockContainer().read(repoSearchReposSortProvider),
        SearchReposSort.bestMatch,
      );
    });
  });
}
