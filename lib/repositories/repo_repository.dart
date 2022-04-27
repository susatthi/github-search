// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../config/env.dart';
import '../entities/repo/repo.dart';
import '../entities/search_repos_result/search_repos_result.dart';
import 'github/api.dart';
import 'github/http_client.dart';
import 'github/repo_repository.dart';

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) {
    const token = String.fromEnvironment(
      dartDefineKeyGitHubAccessToken,
      defaultValue: Env.gitHubAccessToken,
    );
    return GitHubRepoRepository(
      api: const GitHubApi(),
      client: GitHubHttpClient(client: http.Client(), token: token),
    );
  },
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<SearchReposResult> searchRepos({
    required String query,
    required RepoParamSearchReposSort sort,
    required RepoParamSearchReposOrder order,
    int? perPage,
    int? page,
  });

  /// リポジトリを取得する
  Future<Repo> getRepo({
    required String ownerName,
    required String repoName,
  });
}

/// リポジトリ検索用ソート
enum RepoParamSearchReposSort {
  bestMatch,
  stars,
  forks,
  helpWantedIssues,
}

extension RepoParamSearchReposSortHelper on RepoParamSearchReposSort {
  /// 文字列からソートを返す
  /// 見つからない場合は IterableElementError.noElement() を投げる
  static RepoParamSearchReposSort valueOf(String name) {
    return RepoParamSearchReposSort.values
        .firstWhere((element) => element.name == name);
  }
}

/// リポジトリ検索用オーダー
enum RepoParamSearchReposOrder {
  desc,
  asc,
}

extension RepoParamSearchReposOrderHelper on RepoParamSearchReposOrder {
  /// 文字列からオーダーを返す
  /// 見つからない場合は IterableElementError.noElement() を投げる
  static RepoParamSearchReposOrder valueOf(String name) {
    return RepoParamSearchReposOrder.values
        .firstWhere((element) => element.name == name);
  }
}
