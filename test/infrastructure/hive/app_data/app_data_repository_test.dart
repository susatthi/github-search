// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/app_data/app_data_repository.dart';
import 'package:github_search/domain/repository/app_data/entity/app_data_key.dart';
import 'package:github_search/domain/repository/repo/entity/search_repos_order.dart';
import 'package:github_search/domain/repository/repo/entity/search_repos_sort.dart';
import 'package:github_search/infrastructure/hive/app_data/app_data_repository.dart';

import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  late AppDataRepository repository;
  setUp(() async {
    await agent.setUp();
    repository = agent.mockContainer().read(hiveAppDataRepositoryProvider);
  });
  tearDown(agent.tearDown);

  group('HiveAppDataRepository', () {
    test('searchReposSort', () async {
      const key = AppDataKey.searchReposSort;

      // 初期値はベストマッチのはず
      expect(
        repository.get<SearchReposSort>(key),
        SearchReposSort.bestMatch,
      );

      // スター数に変更する
      repository.set<SearchReposSort>(key, SearchReposSort.stars);

      // スター数になるはず
      expect(
        repository.get<SearchReposSort>(key),
        SearchReposSort.stars,
      );

      // フォーク数に変更する
      repository.set<SearchReposSort>(key, SearchReposSort.forks);

      // フォーク数になるはず
      expect(
        repository.get<SearchReposSort>(key),
        SearchReposSort.forks,
      );

      // ヘルプ数に変更する
      repository.set<SearchReposSort>(key, SearchReposSort.helpWantedIssues);

      // ヘルプ数になるはず
      expect(
        repository.get<SearchReposSort>(key),
        SearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      repository.set<SearchReposSort>(key, SearchReposSort.bestMatch);

      // ベストマッチになるはず
      expect(
        repository.get<SearchReposSort>(key),
        SearchReposSort.bestMatch,
      );
    });
    test('searchReposOrder', () async {
      const key = AppDataKey.searchReposOrder;

      // 初期値は降順のはず
      expect(
        repository.get<SearchReposOrder>(key),
        SearchReposOrder.desc,
      );

      // 昇順に変更する
      repository.set<SearchReposOrder>(key, SearchReposOrder.asc);

      // 昇順になるはず
      expect(
        repository.get<SearchReposOrder>(key),
        SearchReposOrder.asc,
      );

      // 降順に変更する
      repository.set<SearchReposOrder>(key, SearchReposOrder.desc);

      // 降順になるはず
      expect(
        repository.get<SearchReposOrder>(key),
        SearchReposOrder.desc,
      );
    });
  });
}
