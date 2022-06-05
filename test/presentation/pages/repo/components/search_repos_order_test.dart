// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/repo/entities/search_repos_order.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_order.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('repoSearchReposOrderProvider', () {
    test('初期値は降順のはず', () async {
      final order = agent.mockContainer().read(repoSearchReposOrderProvider);
      expect(order, SearchReposOrder.desc);
    });
  });
  group('repoSearchReposOrderUpdater', () {
    test('オーダー値を変更できるはず', () async {
      final updater = agent.mockContainer().read(repoSearchReposOrderUpdater);

      // 昇順に変更する
      updater(SearchReposOrder.asc);

      // 昇順のはず
      expect(
        agent.mockContainer().read(repoSearchReposOrderProvider),
        SearchReposOrder.asc,
      );

      // 降順に変更する
      updater(SearchReposOrder.desc);

      // 降順のはず
      expect(
        agent.mockContainer().read(repoSearchReposOrderProvider),
        SearchReposOrder.desc,
      );
    });
  });
}
