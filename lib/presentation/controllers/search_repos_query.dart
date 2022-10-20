// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/exceptions.dart';
import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/env/env.dart';
import '../../../../utils/env/env_define.dart';
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
    try {
      await queryHistoryRepository.add(
        QueryHistory.create(queryString),
      );
    } on ValidatorException catch (e) {
      logger.i(e);
    }
  }
}

/// 入力中のリポジトリ検索文字列プロバイダー
final searchReposEnteringQueryProvider =
    StateNotifierProvider<SearchReposEnteringQueryController, String>(
  (ref) => SearchReposEnteringQueryController(
    initQuery: ref.watch(searchReposQueryProvider),
  ),
);

/// 入力中のリポジトリ検索文字列コントローラー
class SearchReposEnteringQueryController extends StateNotifier<String> {
  SearchReposEnteringQueryController({
    required String initQuery,
  }) : super(initQuery);

  /// 保留中の検索文字列
  String? holdQueryString;

  /// 更新する
  Future<void> update(String queryString) async {
    // もし現在の文字列と同じ場合は更新しない
    if (state == queryString) {
      return;
    }

    holdQueryString = queryString;

    // 連続で入力されると負荷があがるので一定時間待つ
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) {
      return;
    }

    // 保留中に次の検索文字列で上書きされたら更新しない
    if (holdQueryString != queryString) {
      return;
    }

    logger.v(
      'Update searchReposEnteringQueryString: queryString = $queryString',
    );
    state = queryString;
    holdQueryString = null;
  }
}
