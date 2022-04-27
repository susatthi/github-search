// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/hive/app_data_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';

import '../../test_utils/hive.dart';
import '../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  late HiveAppDataRepository repository;
  setUp(() async {
    tmpDir = await openAppDataBox();
    repository = mockProviderContainer().read(hiveAppDataRepositoryProvider);
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('HiveAppDataRepository', () {
    test('setSearchReposSort() / getSearchReposSort()', () async {
      // 初期値はベストマッチのはず
      expect(
        repository.getSearchReposSort(),
        RepoSearchReposSort.bestMatch,
      );

      // スター数に変更する
      repository.setSearchReposSort(RepoSearchReposSort.stars);

      // スター数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoSearchReposSort.stars,
      );

      // フォーク数に変更する
      repository.setSearchReposSort(RepoSearchReposSort.forks);

      // フォーク数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoSearchReposSort.forks,
      );

      // ヘルプ数に変更する
      repository.setSearchReposSort(RepoSearchReposSort.helpWantedIssues);

      // ヘルプ数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoSearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      repository.setSearchReposSort(RepoSearchReposSort.bestMatch);

      // ベストマッチになるはず
      expect(
        repository.getSearchReposSort(),
        RepoSearchReposSort.bestMatch,
      );
    });
    test('setSearchReposOrder() / getSearchReposOrder()', () async {
      // 初期値は降順のはず
      expect(
        repository.getSearchReposOrder(),
        RepoSearchReposOrder.desc,
      );

      // 昇順に変更する
      repository.setSearchReposOrder(RepoSearchReposOrder.asc);

      // 昇順になるはず
      expect(
        repository.getSearchReposOrder(),
        RepoSearchReposOrder.asc,
      );

      // 降順に変更する
      repository.setSearchReposOrder(RepoSearchReposOrder.desc);

      // 降順になるはず
      expect(
        repository.getSearchReposOrder(),
        RepoSearchReposOrder.desc,
      );
    });
  });
}
