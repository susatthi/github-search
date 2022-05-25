// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/repo.dart';
import '../../domain/entities/repo_search_repos_order.dart';
import '../../domain/entities/repo_search_repos_sort.dart';
import '../../domain/entities/search_repos_result.dart';
import '../../domain/repositories/repo_repository.dart';
import 'api.dart';
import 'exception.dart';
import 'http_client.dart';
import 'json_object/repo/repo.dart';
import 'json_object/search_repos_result/search_repos_result.dart';

/// GitHubAPI版リポジトリRepositoryプロバイダー
final githubRepoRepositoryProvider = Provider<RepoRepository>(
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
        responseBuilder: (data) {
          final jsonObject = SearchReposResultJsonObject.fromJson(data);
          return SearchReposResult(
            totalCount: jsonObject.totalCount,
            query: query,
            items: jsonObject.items.map(repoBuilder).toList(),
          );
        },
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
        responseBuilder: (data) => repoBuilder(RepoJsonObject.fromJson(data)),
      );

  static Repo repoBuilder(RepoJsonObject jsonObject) {
    final ownerUrl = '$githubSiteUrl/${jsonObject.owner.login}';
    final repoUrl = '$ownerUrl/${jsonObject.name}';
    return Repo(
      ownerName: jsonObject.owner.login,
      avatarUrl: jsonObject.owner.avatarUrl,
      ownerUrl: ownerUrl,
      repoName: jsonObject.name,
      fullName: jsonObject.fullName,
      description: jsonObject.description,
      stargazersCount: jsonObject.stargazersCount,
      watchersCount: jsonObject.watchersCount,
      language: jsonObject.language,
      forksCount: jsonObject.forksCount,
      openIssuesCount: jsonObject.openIssuesCount,
      defaultBranch: jsonObject.defaultBranch,
      repoUrl: repoUrl,
      stargazersUrl: '$repoUrl/stargazers',
      watchersUrl: '$repoUrl/watchers',
      forksUrl: '$repoUrl/network/members',
      issuesUrl: '$repoUrl/issues',
    );
  }

  @override
  Future<String> getReadme({
    required Repo repo,
  }) async {
    // READMEファイル名のパターン（優先度順）
    const fileNames = <String>[
      'README.md',
      'ReadMe.md',
      'Readme.md',
      'readme.md',
    ];

    for (final fileName in fileNames) {
      final uri = Uri.parse(
        'https://raw.githubusercontent.com/${repo.ownerName}/${repo.repoName}/${repo.defaultBranch}/$fileName',
      );
      try {
        return await _client.getRaw(uri: uri);
      } on GitHubException catch (e) {
        // 404 の場合はファイル名を変えてリトライする
        if (e.code == GitHubException.codeNotFound) {
          continue;
        }

        // 404 以外のエラーは即時 rethrow する
        rethrow;
      }
    }

    // 最終的に取得できなかったら 404 を返す
    throw GitHubException.notFound();
  }
}
