// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/env.dart';
import '../../../../config/env_define.dart';
import '../../../../domain/repositories/query_history/entities/query_history_input.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/logger.dart';

/// リポジトリ検索文字列初期値プロバイダー
final searchReposInitQueryProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyDefaultSearchValue,
    //ignore: avoid_redundant_argument_values
    defaultValue: Env.defaultSearchValue,
  ),
);

/// リポジトリ検索文字列プロバイダー
final searchReposQueryProvider =
    StateNotifierProvider<SearchReposQueryController, String>(
  (ref) => SearchReposQueryController(
    queryHistoryRepository: ref.watch(queryHistoryRepositoryProvider),
    initQuery: ref.watch(searchReposInitQueryProvider),
  ),
  name: 'searchReposQueryProvider',
);

/// リポジトリ検索文字列コントローラー
class SearchReposQueryController extends StateNotifier<String> {
  SearchReposQueryController({
    required this.queryHistoryRepository,
    required String initQuery,
  }) : super(initQuery);

  final QueryHistoryRepository queryHistoryRepository;

  /// 更新する
  Future<void> update(String queryString) async {
    state = queryString;
    await queryHistoryRepository.add(
      QueryHistoryInput(queryString: queryString),
    );
  }
}

/// 入力中のリポジトリ検索文字列プロバイダー
final searchReposEnteringQueryProvider = StateProvider<String>(
  (ref) => ref.watch(searchReposQueryProvider),
);

/// 入力中のリポジトリ検索文字列更新メソッドプロバイダー
final searchReposEnteringQueryStringUpdater = Provider(
  (ref) {
    final read = ref.read;
    return (String queryString) async {
      final notifier = read(searchReposEnteringQueryProvider.notifier);
      // もし現在の文字列と同じ場合は更新しない
      final current = ref.read(searchReposEnteringQueryProvider);
      if (current != queryString) {
        logger.v(
          'Update searchReposEnteringQueryString: queryString = $queryString',
        );
        notifier.state = queryString;
      }
    };
  },
);
