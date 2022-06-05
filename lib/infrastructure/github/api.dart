// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../../domain/entities/search_repos_order.dart';
import '../../domain/entities/search_repos_sort.dart';

/// GitHub の URL
const githubSiteUrl = 'https://github.com';

/// GitHub API の定義
/// 各APIはUriを返す
class GitHubApi {
  const GitHubApi();

  static const _scheme = 'https';
  static const _apiUrl = 'api.github.com';
  static const _apiPath = '';

  /// Uriを構築する
  Uri _buildUri({
    required String endpoint,
    Map<String, String> Function()? parametersBuilder,
  }) {
    return Uri(
      scheme: _scheme,
      host: _apiUrl,
      path: '$_apiPath$endpoint',
      queryParameters: parametersBuilder != null ? parametersBuilder() : null,
    );
  }

  /// https://docs.github.com/ja/rest/reference/search#search-repositories
  Uri searchRepos({
    required String queryString,
    GitHubSearchReposSort? sort,
    GitHubSearchReposOrder? order,
    int? perPage,
    int? page,
  }) {
    assert(queryString.isNotEmpty);
    assert(perPage == null || (0 < perPage && perPage <= 100));
    assert(page == null || 0 < page);
    return _buildUri(
      endpoint: '/search/repositories',
      parametersBuilder: () {
        return {
          'q': queryString,
          if (sort != null) 'sort': sort.jsonName,
          if (order != null) 'order': order.jsonName,
          if (perPage != null) 'per_page': '$perPage',
          if (page != null) 'page': '$page',
        };
      },
    );
  }

  /// https://docs.github.com/ja/rest/reference/repos#get-a-repository
  Uri getRepo({
    required String ownerName,
    required String repoName,
  }) {
    assert(ownerName.isNotEmpty);
    assert(repoName.isNotEmpty);
    return _buildUri(
      endpoint: '/repos/$ownerName/$repoName',
    );
  }
}

/// GitHub リポジトリ検索用ソート
enum GitHubSearchReposSort {
  stars('stars'),
  forks('forks'),
  helpWantedIssues('help-wanted-issues');

  const GitHubSearchReposSort(this.jsonName);

  final String jsonName;

  /// SearchReposSort => GitHubSearchReposSort?
  static GitHubSearchReposSort? valueOf(SearchReposSort sort) {
    switch (sort) {
      case SearchReposSort.bestMatch:
        return null;
      case SearchReposSort.stars:
        return GitHubSearchReposSort.stars;
      case SearchReposSort.forks:
        return GitHubSearchReposSort.forks;
      case SearchReposSort.helpWantedIssues:
        return GitHubSearchReposSort.helpWantedIssues;
    }
  }
}

/// GitHub リポジトリ検索用オーダー
enum GitHubSearchReposOrder {
  desc('desc'),
  asc('asc');

  const GitHubSearchReposOrder(this.jsonName);

  final String jsonName;

  /// SearchReposOrder => GitHubSearchReposOrder
  static GitHubSearchReposOrder valueOf(
    SearchReposOrder order,
  ) {
    switch (order) {
      case SearchReposOrder.desc:
        return GitHubSearchReposOrder.desc;
      case SearchReposOrder.asc:
        return GitHubSearchReposOrder.asc;
    }
  }
}
