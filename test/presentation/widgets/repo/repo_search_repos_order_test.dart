// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_repos_order.dart';
import 'package:github_search/repositories/repo_repository.dart';

import '../../../test_utils/hive.dart';

void main() {
  late Directory tmpDir;
  late ProviderContainer container;
  setUp(() async {
    tmpDir = await openAppDataBox();
    container = ProviderContainer();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('repoSearchReposOrderProvider', () {
    test('初期値は降順のはず', () async {
      final order = container.read(repoSearchReposOrderProvider);
      expect(order, RepoParamSearchReposOrder.desc);
    });
  });
  group('RepoSearchReposOrderController', () {
    test('オーダーを変更できるはず', () async {
      // 昇順に変更する
      final controller = container.read(repoSearchReposOrderProvider.notifier)
        ..update(order: RepoParamSearchReposOrder.asc);

      // 昇順のはず
      expect(
        container.read(repoSearchReposOrderProvider),
        RepoParamSearchReposOrder.asc,
      );

      // 降順に変更する
      controller.update(order: RepoParamSearchReposOrder.desc);

      // 降順のはず
      expect(
        container.read(repoSearchReposOrderProvider),
        RepoParamSearchReposOrder.desc,
      );
    });
  });
}