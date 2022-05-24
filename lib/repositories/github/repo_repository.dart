// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/repo/repo.dart';
import '../../entities/search_repos_result/search_repos_result.dart';
import '../repo_repository.dart';
import 'api.dart';
import 'exception.dart';
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
        responseBuilder: (data) {
          final result = SearchReposResult.fromJson(data);
          return result.copyWith(
            items: result.items.map(repoBuilder).toList(),
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
        responseBuilder: (data) => repoBuilder(Repo.fromJson(data)),
      );

  static Repo repoBuilder(Repo repo) {
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
  }

  @override
  Future<String> getReadme({
    required String ownerName,
    required String repoName,
    required String defaultBranch,
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
        'https://raw.githubusercontent.com/$ownerName/$repoName/$defaultBranch/$fileName',
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
