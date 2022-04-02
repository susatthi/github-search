// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/entities/search_repos_result/search_repos_result.dart';
import 'package:github_search/repositories/github/api.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:github_search/repositories/repo_repository.dart';

/// GitHubAPI用リポジトリRepository
class GitHubRepoRepository implements RepoRepository {
  const GitHubRepoRepository({
    required GitHubApi api,
    required GitHubHttpClient client,
  })  : _api = api,
        _client = client;

  final GitHubApi _api;
  final GitHubHttpClient _client;

  @override
  Future<SearchReposResult> searchRepos({
    required String query,
    int? perPage,
    int? page,
  }) async =>
      _client.get<SearchReposResult>(
        uri: _api.searchRepos(
          query: query,
          perPage: perPage,
          page: page,
        ),
        responseBuilder: SearchReposResult.fromJson,
      );

  @override
  Future<Repo> getRepo({
    required String ownerName,
    required String repoName,
  }) async =>
      _client.get<Repo>(
        uri: _api.getRepo(
          ownerName: ownerName,
          repoName: repoName,
        ),
        responseBuilder: Repo.fromJson,
      );
}
