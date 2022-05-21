// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/repo/repo.dart';
import '../../entities/search_repos_result/search_repos_result.dart';
import '../repo_repository.dart';
import 'api.dart';
import 'http_client.dart';

/// GitHub の URL
const githubSiteUrl = 'https://github.com';

/// GitHubAPI版リポジトリRepositoryプロバイダー
final githubRepoRepositoryProvider = Provider<GitHubRepoRepository>(
  (ref) {
    final githubHttpClient = ref.watch(githubHttpClientProvider);
    return GitHubRepoRepository(
      api: const GitHubApi(),
      client: githubHttpClient,
    );
  },
);

/// GitHubAPI版リポジトリRepository
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
    required RepoSearchReposSort sort,
    required RepoSearchReposOrder order,
    int? perPage,
    int? page,
  }) async =>
      _client.get<SearchReposResult>(
        uri: _api.searchRepos(
          query: query,
          sort: GitHubRepoSearchReposSort.valueOf(sort),
          order: GitHubRepoSearchReposOrder.valueOf(order),
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
        responseBuilder: (data) {
          final repo = Repo.fromJson(data);
          final ownerUrl = '$githubSiteUrl/${repo.owner.login}';
          final repoUrl = '$ownerUrl/${repo.name}';
          return repo.copyWith(
            owner: repo.owner.copyWith(
              ownerUrl: ownerUrl,
            ),
            repoUrl: repoUrl,
            stargazersUrl: '$repoUrl/stargazers',
            watchersUrl: '$repoUrl/watchers',
            forksUrl: '$repoUrl/network/members',
            issuesUrl: '$repoUrl/issues',
          );
        },
      );
}
