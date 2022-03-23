// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// Github API の定義
/// 各APIはUriを返す
class GithubApi {
  const GithubApi();

  static const _scheme = 'https';
  static const _apiUrl = 'api.github.com';
  static const _apiPath = '';

  /// Uriを構築する
  Uri _buildUri({
    required String endpoint,
    Map<String, dynamic> Function()? parametersBuilder,
  }) {
    return Uri(
      scheme: _scheme,
      host: _apiUrl,
      path: '$_apiPath$endpoint',
      queryParameters:
          parametersBuilder != null ? parametersBuilder() : <String, dynamic>{},
    );
  }

  /// https://docs.github.com/ja/rest/reference/search#search-repositories
  Uri searchRepositories({
    required String query,
    GAParamSearchRepositoriesSort? sort,
    GAParamOrder? order,
    GAParamPerPage? perPage,
    GAParamPage? page,
  }) =>
      _buildUri(
        endpoint: '/search/repositories',
        parametersBuilder: () {
          assert(perPage == null || !(0 < perPage && perPage <= 100));
          assert(page == null || 0 >= page);
          return <String, dynamic>{
            'q': query,
            if (sort != null) 'sort': sort.name,
            if (order != null) 'order': order.name,
            if (perPage != null) 'perPage': perPage,
            if (page != null) 'page': page,
          };
        },
      );
}

/// Sorts the results of your query
enum GAParamSearchRepositoriesSort {
  stars,
  forks,
  helpWantedIssues,
}

extension GAParamSearchRepositoriesSortHelper on GAParamSearchRepositoriesSort {
  static final names = <GAParamSearchRepositoriesSort, String>{
    GAParamSearchRepositoriesSort.stars: 'stars',
    GAParamSearchRepositoriesSort.forks: 'forks',
    GAParamSearchRepositoriesSort.helpWantedIssues: 'help-wanted-issues',
  };

  /// override
  String get name => names[this]!;
}

/// Determines whether the first search result returned is the highest number
/// of matches (desc) or lowest number of matches (asc). This parameter is
/// ignored unless you provide sort.
enum GAParamOrder {
  asc,
  desc,
}

/// Results per page (max 100)
typedef GAParamPerPage = int;

/// Page number of the results to fetch.
typedef GAParamPage = int;
