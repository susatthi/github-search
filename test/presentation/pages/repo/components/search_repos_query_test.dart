// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/env.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('searchReposInitQueryStringProvider', () {
    test('初期値は環境変数の値と一致するはず', () async {
      final query =
          ProviderContainer().read(searchReposInitQueryStringProvider);
      expect(query, Env.defaultSearchValue);
    });
  });
  group('searchReposQueryStringUpdater', () {
    test('検索文字列を変更できるはず', () async {
      // 検索文字列を変更する
      await agent.mockContainer().read(searchReposQueryStringUpdater)('dummy');
      final query = agent.mockContainer().read(searchReposQueryStringProvider);
      expect(query, 'dummy');
    });
  });
  group('searchReposEnteringQueryStringUpdater', () {
    test('入力中の検索文字列を変更できるはず', () async {
      // 入力中の検索文字列を変更する
      await agent
          .mockContainer()
          .read(searchReposEnteringQueryStringUpdater)('dummy');
      final query =
          agent.mockContainer().read(searchReposEnteringQueryStringProvider);
      expect(query, 'dummy');
    });
  });
}
