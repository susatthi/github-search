// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/src/config/constants.dart';
import 'package:github_search/src/config/env.dart';
import 'package:github_search/src/entities/repo/repo.dart';
import 'package:github_search/src/repositories/github/api.dart';
import 'package:github_search/src/repositories/github/http_client.dart';
import 'package:github_search/src/repositories/github/repo_repository.dart';
import 'package:http/http.dart' as http;

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) {
    const token = String.fromEnvironment(
      kDartDefineKeyGithubOAuthToken,
      defaultValue: Env.githubOAuthToken,
    );
    return GithubRepoRepository(
      api: const GithubApi(),
      client: GithubHttpClient(client: http.Client(), token: token),
    );
  },
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<SearchReposResult> searchRepos({
    required String query,
    int? perPage,
    int? page,
  });

  /// リポジトリを取得する
  Future<Repo> getRepo({
    required String ownerName,
    required String repoName,
  });
}
