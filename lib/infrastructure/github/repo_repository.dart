// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/repo_repository.dart';
import 'api.dart';
import 'exception.dart';
import 'http_client.dart';
import 'json_object/repo/repo.dart';
import 'json_object/search_repos_result/search_repos_result.dart';

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
  Future<SearchReposResultJsonObject> searchRepos({
    required String query,
    required RepoSearchReposSort sort,
    required RepoSearchReposOrder order,
    int? perPage,
    int? page,
  }) async =>
      _client.get<SearchReposResultJsonObject>(
        uri: _api.searchRepos(
          query: query,
          sort: GitHubRepoSearchReposSort.valueOf(sort),
          order: GitHubRepoSearchReposOrder.valueOf(order),
          perPage: perPage,
          page: page,
        ),
        responseBuilder: (data) {
          final result = SearchReposResultJsonObject.fromJson(data);
          return result.copyWith(
            items: result.items.map(repoBuilder).toList(),
          );
        },
      );

  @override
  Future<RepoJsonObject> getRepo({
    required String ownerName,
    required String repoName,
  }) async =>
      _client.get<RepoJsonObject>(
        uri: _api.getRepo(
          ownerName: ownerName,
          repoName: repoName,
        ),
        responseBuilder: (data) => repoBuilder(RepoJsonObject.fromJson(data)),
      );

  static RepoJsonObject repoBuilder(RepoJsonObject repo) {
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
