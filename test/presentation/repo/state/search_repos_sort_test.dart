// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/search_repos_sort.dart';
import 'package:github_search/presentation/repo/state/search_repos_sort.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  late ProviderContainer container;
  setUp(() async {
    tmpDir = await openAppDataBox();
    container = mockProviderContainer();
    useEnvironmentLocale();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('repoSearchReposSortProvider', () {
    test('初期値はベストマッチのはず', () async {
      final sort = container.read(repoSearchReposSortProvider);
      expect(sort, SearchReposSort.bestMatch);
    });
  });
  group('repoSearchReposSortUpdaterProvider', () {
    test('ソート値を変更できるはず', () async {
      final updater = container.read(repoSearchReposSortUpdaterProvider);

      // スター数に変更する
      updater(SearchReposSort.stars);

      // スター数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        SearchReposSort.stars,
      );

      // フォーク数に変更する
      updater(SearchReposSort.forks);

      // フォーク数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        SearchReposSort.forks,
      );

      // ヘルプ数に変更する
      updater(SearchReposSort.helpWantedIssues);

      // ヘルプ数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        SearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      updater(SearchReposSort.bestMatch);

      // ベストマッチのはず
      expect(
        container.read(repoSearchReposSortProvider),
        SearchReposSort.bestMatch,
      );
    });
  });
}
