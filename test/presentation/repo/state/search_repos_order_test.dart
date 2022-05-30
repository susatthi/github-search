// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/search_repos_order.dart';
import 'package:github_search/presentation/repo/state/search_repos_order.dart';

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

  group('repoSearchReposOrderProvider', () {
    test('初期値は降順のはず', () async {
      final order = container.read(repoSearchReposOrderProvider);
      expect(order, SearchReposOrder.desc);
    });
  });
  group('repoSearchReposOrderUpdater', () {
    test('オーダー値を変更できるはず', () async {
      final updater = container.read(repoSearchReposOrderUpdater);

      // 昇順に変更する
      updater(SearchReposOrder.asc);

      // 昇順のはず
      expect(
        container.read(repoSearchReposOrderProvider),
        SearchReposOrder.asc,
      );

      // 降順に変更する
      updater(SearchReposOrder.desc);

      // 降順のはず
      expect(
        container.read(repoSearchReposOrderProvider),
        SearchReposOrder.desc,
      );
    });
  });
}
