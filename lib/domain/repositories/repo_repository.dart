// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/github/repo_repository.dart';
import '../entities/repo.dart';
import '../entities/repo_search_repos_order.dart';
import '../entities/repo_search_repos_sort.dart';
import '../entities/search_repos_result.dart';

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) => ref.watch(githubRepoRepositoryProvider),
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<SearchReposResult> searchRepos({
    required String query,
    required RepoSearchReposSort sort,
    required RepoSearchReposOrder order,
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
