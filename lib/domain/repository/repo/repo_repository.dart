// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entity/repo.dart';
import 'entity/repo_param.dart';
import 'entity/search_repos_order.dart';
import 'entity/search_repos_result.dart';
import 'entity/search_repos_sort.dart';

/// リポジトリプロバイダー（Family）
final repoProviderFamily = FutureProvider.family.autoDispose<Repo, RepoParam>(
  (ref, param) async {
    final cache = param.cache;
    if (cache != null) {
      // キャッシュがあればそのまま使う
      return cache;
    }

    // extra が無いので取得する
    return ref.watch(repoRepositoryProvider).getRepo(
          ownerName: param.ownerName,
          repoName: param.repoName,
        );
  },
  name: 'repoProviderFamily',
);

/// READMEプロバイダー（Family）
final readmeProviderFamily = FutureProvider.family.autoDispose<String, Repo>(
  (ref, repo) => ref.watch(repoRepositoryProvider).getReadme(
        repo: repo,
      ),
  name: 'readmeProviderFamily',
);

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<SearchReposResult> searchRepos({
    required String queryString,
    required SearchReposSort sort,
    required SearchReposOrder order,
    int? perPage,
    int? page,
  });

  /// リポジトリを取得する
  Future<Repo> getRepo({
    required String ownerName,
    required String repoName,
  });

  /// READMEコンテンツを取得する
  Future<String> getReadme({
    required Repo repo,
  });
}
