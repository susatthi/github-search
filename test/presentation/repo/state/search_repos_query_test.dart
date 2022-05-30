// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/env.dart';
import 'package:github_search/presentation/repo/state/search_repos_query.dart';

import '../../../test_utils/locale.dart';

void main() {
  late ProviderContainer container;
  setUp(() async {
    container = ProviderContainer();
    useEnvironmentLocale();
  });

  group('repoSearchReposInitQueryProvider', () {
    test('初期値は環境変数の値と一致するはず', () async {
      final query = container.read(repoSearchReposInitQueryProvider);
      expect(query, Env.defaultSearchValue);
    });
  });
  group('repoSearchReposQueryProvider', () {
    test('検索文字列を変更できるはず', () async {
      // 検索文字列を変更する
      container.read(repoSearchReposQueryProvider.notifier).state = 'dummy';
      final query = container.read(repoSearchReposQueryProvider);
      expect(query, 'dummy');
    });
  });
}
