// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/env/env.dart';
import '../../../../utils/env/env_define.dart';
import '../../utils/logger.dart';
import '../exceptions.dart';

/// リポジトリ検索文字列初期値プロバイダー
final searchReposInitQueryProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyDefaultSearchValue,
    //ignore: avoid_redundant_argument_values
    defaultValue: Env.defaultSearchValue,
  ),
);

/// リポジトリ検索文字列プロバイダー
final searchReposQueryProvider = StateProvider<String>(
  (ref) => ref.watch(searchReposInitQueryProvider),
  name: 'searchReposQueryProvider',
);

/// 入力中のリポジトリ検索文字列プロバイダー
final searchReposEnteringQueryProvider = StateProvider<String>(
  (ref) => ref.watch(searchReposQueryProvider),
);

/// 検索履歴一覧のFutureプロバイダー
final _queryHistoriesFutureProviderFamily =
    FutureProvider.autoDispose.family<List<QueryHistory>, String>(
  (ref, queryString) =>
      ref.watch(queryHistoryRepositoryProvider).finds(queryString: queryString),
);

/// 検索履歴一覧のStreamプロバイダー
final _queryHistoriesStreamProviderFamily =
    StreamProvider.autoDispose.family<List<QueryHistory>, String>(
  (ref, queryString) => ref
      .watch(queryHistoryRepositoryProvider)
      .changes(queryString: queryString),
);

/// リポジトリ検索履歴一覧プロバイダー
final searchReposQueryHistoriesProvider =
    FutureProvider.autoDispose<List<QueryHistory>>(
  (ref) {
    final enteringQueryString = ref.watch(searchReposEnteringQueryProvider);
    ref.listen(
      _queryHistoriesStreamProviderFamily(enteringQueryString),
      (previous, next) {
        ref.state = next;
      },
    );
    return ref
        .watch(_queryHistoriesFutureProviderFamily(enteringQueryString).future);
  },
  name: 'searchReposQueryHistoriesProvider',
);

// リポジトリ検索コントローラープロバイダー
final searchReposQueryControllerProvider = Provider<SearchReposQueryController>(
  SearchReposQueryController.new,
);

/// リポジトリ検索コントローラー
class SearchReposQueryController {
  SearchReposQueryController(this.ref);

  final Ref ref;

  /// 保留中の検索文字列
  String? holdQueryString;

  /// リポジトリ検索文字列を入力する
  Future<void> enter(String queryString) async {
    // もし現在入力中の文字列と同じ場合は更新しない
    if (ref.read(searchReposEnteringQueryProvider) == queryString) {
      return;
    }

    holdQueryString = queryString;

    // 連続で入力されると負荷があがるので一定時間待つ
    await Future<void>.delayed(const Duration(milliseconds: 300));

    // 保留中に次の検索文字列で上書きされたら更新しない
    if (holdQueryString != queryString) {
      return;
    }

    ref.read(searchReposEnteringQueryProvider.notifier).state = queryString;
    holdQueryString = null;
  }

  /// リポジトリ検索文字列をクリアする
  Future<void> clear() async {
    ref.read(searchReposQueryProvider.notifier).state = '';
  }

  /// リポジトリ検索文字列を確定する
  Future<void> done(String queryString) async {
    ref.read(searchReposQueryProvider.notifier).state = queryString;

    try {
      await ref.read(queryHistoryRepositoryProvider).add(
            QueryHistory.create(queryString.trim()),
          );
    } on ValidatorException catch (e) {
      // エラーが起きても何もしない
      logger.v(e);
    }
  }

  /// リポジトリ検索履歴を選択する
  Future<void> select(QueryHistory queryHistory) async {
    ref.read(searchReposQueryProvider.notifier).state =
        queryHistory.queryString.value;
    await ref.read(queryHistoryRepositoryProvider).add(queryHistory);
  }

  /// リポジトリ検索履歴を削除する
  Future<void> delete(QueryHistory queryHistory) async {
    await ref.read(queryHistoryRepositoryProvider).delete(queryHistory);
  }
}
