// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_sort_selector_dialog.dart';
import 'package:github_search/repositories/repo_repository.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
  });

  group('searchReposSortProvider', () {
    test('初期値はベストマッチのはず', () async {
      final sort = container.read(searchReposSortProvider);
      expect(sort, RepoParamSearchReposSort.bestMatch);
    });
    test('ソートを変更できるはず', () async {
      container.read(searchReposSortProvider.notifier).state =
          RepoParamSearchReposSort.stars;
      final sort = container.read(searchReposSortProvider);
      expect(sort, RepoParamSearchReposSort.stars);
    });
  });
}
