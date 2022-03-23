// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo_response.dart';
import 'package:github_search/repository/githubApi/api.dart';
import 'package:github_search/repository/githubApi/http_client.dart';
import 'package:github_search/repository/repo_repository.dart';

/// GithubAPI用リポジトリRepository
class GithubApiRepoRepository implements RepoRepository {
  const GithubApiRepoRepository({
    required GithubApi api,
    required GithubApiHttpClient client,
  })  : _api = api,
        _client = client;

  final GithubApi _api;
  final GithubApiHttpClient _client;

  @override
  Future<SearchReposResultResponse> searchRepos({
    required String query,
  }) async =>
      _client.get<SearchReposResultResponse>(
        uri: _api.searchRepositories(query: query),
        responseBuilder: SearchReposResultResponse.fromJson,
      );
}
