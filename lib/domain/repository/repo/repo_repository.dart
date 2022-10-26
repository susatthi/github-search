// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entity/repo.dart';
import 'entity/search_repos_order.dart';
import 'entity/search_repos_result.dart';
import 'entity/search_repos_sort.dart';

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// READMEプロバイダー（Family）
final readmeProviderFamily = FutureProvider.family.autoDispose<String, Repo>(
  (ref, repo) => ref.watch(repoRepositoryProvider).getReadme(
        repo: repo,
      ),
  name: 'readmeProviderFamily',
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
