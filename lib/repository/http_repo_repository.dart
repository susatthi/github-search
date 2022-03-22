// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo.dart';
import 'package:github_search/repository/dataSource/github/api.dart';
import 'package:github_search/repository/dataSource/github/http_client.dart';
import 'package:github_search/repository/repo_repository.dart';

/// HTTP通信用リポジトリRepository
class HttpRepoRepository implements RepoRepository {
  const HttpRepoRepository({
    required GithubApi api,
    required GithubHttpClient client,
  })  : _api = api,
        _client = client;

  final GithubApi _api;
  final GithubHttpClient _client;

  @override
  Future<ReposResult> searchRepos({
    required String query,
  }) async =>
      _client.get<ReposResult>(
        uri: _api.searchRepositories(query: query),
        builder: (dynamic data) =>
            ReposResult.fromJson(data as Map<String, dynamic>),
      );
}
