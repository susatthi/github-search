// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/search_repos_order.dart';
import 'package:github_search/domain/entities/search_repos_sort.dart';
import 'package:github_search/domain/repositories/app_data_repository.dart';
import 'package:github_search/infrastructure/hive/app_data_repository.dart';

import '../../test_utils/hive.dart';
import '../../test_utils/locale.dart';
import '../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  late AppDataRepository repository;
  setUp(() async {
    tmpDir = await openAppDataBox();
    repository = mockProviderContainer().read(hiveAppDataRepositoryProvider);
    useEnvironmentLocale();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('HiveAppDataRepository', () {
    test('setSearchReposSort() / getSearchReposSort()', () async {
      // 初期値はベストマッチのはず
      expect(
        repository.getSearchReposSort(),
        SearchReposSort.bestMatch,
      );

      // スター数に変更する
      repository.setSearchReposSort(SearchReposSort.stars);

      // スター数になるはず
      expect(
        repository.getSearchReposSort(),
        SearchReposSort.stars,
      );

      // フォーク数に変更する
      repository.setSearchReposSort(SearchReposSort.forks);

      // フォーク数になるはず
      expect(
        repository.getSearchReposSort(),
        SearchReposSort.forks,
      );

      // ヘルプ数に変更する
      repository.setSearchReposSort(SearchReposSort.helpWantedIssues);

      // ヘルプ数になるはず
      expect(
        repository.getSearchReposSort(),
        SearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      repository.setSearchReposSort(SearchReposSort.bestMatch);

      // ベストマッチになるはず
      expect(
        repository.getSearchReposSort(),
        SearchReposSort.bestMatch,
      );
    });
    test('setSearchReposOrder() / getSearchReposOrder()', () async {
      // 初期値は降順のはず
      expect(
        repository.getSearchReposOrder(),
        SearchReposOrder.desc,
      );

      // 昇順に変更する
      repository.setSearchReposOrder(SearchReposOrder.asc);

      // 昇順になるはず
      expect(
        repository.getSearchReposOrder(),
        SearchReposOrder.asc,
      );

      // 降順に変更する
      repository.setSearchReposOrder(SearchReposOrder.desc);

      // 降順になるはず
      expect(
        repository.getSearchReposOrder(),
        SearchReposOrder.desc,
      );
    });
  });
}
