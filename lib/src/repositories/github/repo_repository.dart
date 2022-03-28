// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/src/entities/repo/repo.dart';
import 'package:github_search/src/entities/search_repos_result/search_repos_result.dart';
import 'package:github_search/src/repositories/github/api.dart';
import 'package:github_search/src/repositories/github/http_client.dart';
import 'package:github_search/src/repositories/repo_repository.dart';

/// GithubAPI用リポジトリRepository
class GithubRepoRepository implements RepoRepository {
  const GithubRepoRepository({
    required GithubApi api,
    required GithubHttpClient client,
  })  : _api = api,
        _client = client;

  final GithubApi _api;
  final GithubHttpClient _client;

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
