// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/search_repos_query.dart';
import '../../domain/exceptions.dart';
import '../../domain/repository/query_history/entity/query_history.dart';
import '../../domain/repository/query_history/query_history_repository.dart';
import '../../util/logger.dart';

// リポジトリ検索サービスプロバイダー
final repoSearchServiceProvider = Provider(
  RepoSearchService.new,
);

/// リポジトリ検索サービス
class RepoSearchService {
  RepoSearchService(this.ref);

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
