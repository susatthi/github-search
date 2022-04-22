// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../../entities/repo/repo.dart';
import '../../entities/search_repos_result/search_repos_result.dart';
import '../repo_repository.dart';
import 'api.dart';
import 'http_client.dart';

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
