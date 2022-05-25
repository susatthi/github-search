// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repo/repositories/repo_repository.dart';
import 'package:github_search/presentation/repo/components/repo_search_repos_sort.dart';

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
      expect(sort, RepoSearchReposSort.bestMatch);
    });
  });
  group('RepoSearchReposSortNotifier', () {
    test('ソート値を変更できるはず', () async {
      // スター数に変更する
      final notifier = container.read(repoSearchReposSortProvider.notifier)
        ..sort = RepoSearchReposSort.stars;

      // スター数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoSearchReposSort.stars,
      );

      // フォーク数に変更する
      notifier.sort = RepoSearchReposSort.forks;

      // フォーク数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoSearchReposSort.forks,
      );

      // ヘルプ数に変更する
      notifier.sort = RepoSearchReposSort.helpWantedIssues;

      // ヘルプ数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoSearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      notifier.sort = RepoSearchReposSort.bestMatch;

      // ベストマッチのはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoSearchReposSort.bestMatch,
      );
    });
  });
}
