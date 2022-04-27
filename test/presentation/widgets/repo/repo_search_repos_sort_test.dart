// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/repo/repo_search_repos_sort.dart';
import 'package:github_search/repositories/repo_repository.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  late ProviderContainer container;
  setUp(() async {
    tmpDir = await openAppDataBox();
    container = mockProviderContainer();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('repoSearchReposSortProvider', () {
    test('初期値はベストマッチのはず', () async {
      final sort = container.read(repoSearchReposSortProvider);
      expect(sort, RepoParamSearchReposSort.bestMatch);
    });
  });
  group('RepoSearchReposSortController', () {
    test('ソート値を変更できるはず', () async {
      // スター数に変更する
      final controller = container.read(repoSearchReposSortProvider.notifier)
        ..sort = RepoParamSearchReposSort.stars;

      // スター数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoParamSearchReposSort.stars,
      );

      // フォーク数に変更する
      controller.sort = RepoParamSearchReposSort.forks;

      // フォーク数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoParamSearchReposSort.forks,
      );

      // ヘルプ数に変更する
      controller.sort = RepoParamSearchReposSort.helpWantedIssues;

      // ヘルプ数のはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoParamSearchReposSort.helpWantedIssues,
      );

      // ベストマッチに変更する
      controller.sort = RepoParamSearchReposSort.bestMatch;

      // ベストマッチのはず
      expect(
        container.read(repoSearchReposSortProvider),
        RepoParamSearchReposSort.bestMatch,
      );
    });
  });
}
