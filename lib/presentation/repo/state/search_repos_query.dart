// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/env.dart';
import '../../../config/env_define.dart';
import '../../../domain/entities/query_history_input.dart';
import '../../../domain/repositories/query_history_repository.dart';

/// リポジトリ検索文字列初期値プロバイダー
final repoSearchReposInitQueryStringProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyDefaultSearchValue,
    //ignore: avoid_redundant_argument_values
    defaultValue: Env.defaultSearchValue,
  ),
);

/// リポジトリ検索文字列プロバイダー
final repoSearchReposQueryStringProvider = StateProvider<String>(
  (ref) => ref.read(repoSearchReposInitQueryStringProvider),
);

/// リポジトリ検索文字列更新メソッドプロバイダー
final repoSearchReposQueryStringUpdater = Provider(
  (ref) => (String queryString) async {
    ref.read(repoSearchReposQueryStringProvider.notifier).state = queryString;
    await ref.read(queryHistoryRepositoryProvider).add(
          QueryHistoryInput(queryString: queryString),
        );
  },
);

/// 入力中のリポジトリ検索文字列プロバイダー
final repoSearchReposEnteringQueryStringProvider = StateProvider<String>(
  (ref) => ref.read(repoSearchReposQueryStringProvider),
);
