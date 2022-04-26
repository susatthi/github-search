// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/constants.dart';
import 'package:github_search/repositories/hive/app_data_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';
import 'package:hive/hive.dart';

import '../../test_utils/mocks.dart';

void main() {
  late HiveAppDataRepository repository;
  setUp(() async {
    await openAppDataBox();
    repository = HiveAppDataRepository(
      box: Hive.box<dynamic>(hiveBoxNameAppData),
    );
  });

  tearDown(() async {
    await closeAppDataBox();
  });

  group('HiveAppDataRepository', () {
    test('setSearchReposSort() / getSearchReposSort()', () async {
      // 初期値はベストマッチのはず
      expect(
        repository.getSearchReposSort(),
        RepoParamSearchReposSort.bestMatch,
      );

      // スター数に変更する
      repository.setSearchReposSort(RepoParamSearchReposSort.stars);

      // スター数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoParamSearchReposSort.stars,
      );

      // フォーク数に変更する
      repository.setSearchReposSort(RepoParamSearchReposSort.forks);

      // フォーク数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoParamSearchReposSort.forks,
      );

      // ヘルプ数に変更する
      repository.setSearchReposSort(RepoParamSearchReposSort.helpWantedIssues);

      // ヘルプ数になるはず
      expect(
        repository.getSearchReposSort(),
        RepoParamSearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      repository.setSearchReposSort(RepoParamSearchReposSort.bestMatch);

      // ベストマッチになるはず
      expect(
        repository.getSearchReposSort(),
        RepoParamSearchReposSort.bestMatch,
      );
    });
    test('setSearchReposOrder() / getSearchReposOrder()', () async {
      // 初期値は降順のはず
      expect(
        repository.getSearchReposOrder(),
        RepoParamSearchReposOrder.desc,
      );

      // 昇順に変更する
      repository.setSearchReposOrder(RepoParamSearchReposOrder.asc);

      // 昇順になるはず
      expect(
        repository.getSearchReposOrder(),
        RepoParamSearchReposOrder.asc,
      );

      // 降順に変更する
      repository.setSearchReposOrder(RepoParamSearchReposOrder.desc);

      // 降順になるはず
      expect(
        repository.getSearchReposOrder(),
        RepoParamSearchReposOrder.desc,
      );
    });
  });
}
