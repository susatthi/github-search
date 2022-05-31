// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/repo.dart';
import '../entities/search_repos_order.dart';
import '../entities/search_repos_result.dart';
import '../entities/search_repos_sort.dart';

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) => throw UnimplementedError(),
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
