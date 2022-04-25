// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/widgets/repo/repo_order_toggle_button.dart';
import 'package:github_search/repositories/repo_repository.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
  });

  group('searchReposOrderProvider', () {
    test('初期値は降順のはず', () async {
      final order = container.read(searchReposOrderProvider);
      expect(order, RepoParamSearchReposOrder.desc);
    });
    test('オーダーを変更できるはず', () async {
      container.read(searchReposOrderProvider.notifier).state =
          RepoParamSearchReposOrder.asc;
      final order = container.read(searchReposOrderProvider);
      expect(order, RepoParamSearchReposOrder.asc);
    });
  });
}
