// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/config/constants.dart';
import 'package:github_search/config/env.dart';
import 'package:github_search/entity/repo/repo_response.dart';
import 'package:github_search/repository/githubApi/api.dart';
import 'package:github_search/repository/githubApi/http_client.dart';
import 'package:github_search/repository/githubApi/repo_repository.dart';
import 'package:http/http.dart' as http;

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) {
    const token = String.fromEnvironment(
      kDartDefineNameGithubOAuthToken,
      defaultValue: Env.githubOAuthToken,
    );
    return GithubApiRepoRepository(
      api: GithubApi(),
      client: GithubApiHttpClient(client: http.Client(), token: token),
    );
  },
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<SearchReposResultResponse> searchRepos({
    required String query,
  });
}
