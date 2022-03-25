// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github_search/src/repositories/github/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// owner json map
const ownerJsonMap = {
  'login': 'keyber-inc',
  'id': 67895511,
  'node_id': 'MDEyOk9yZ2FuaXphdGlvbjY3ODk1NTEx',
  'avatar_url': 'https://avatars.githubusercontent.com/u/67895511?v=4',
  'gravatar_id': '',
  'url': 'https://api.github.com/users/keyber-inc',
  'html_url': 'https://github.com/keyber-inc',
  'followers_url': 'https://api.github.com/users/keyber-inc/followers',
  'following_url':
      'https://api.github.com/users/keyber-inc/following{/other_user}',
  'gists_url': 'https://api.github.com/users/keyber-inc/gists{/gist_id}',
  'starred_url':
      'https://api.github.com/users/keyber-inc/starred{/owner}{/repo}',
  'subscriptions_url': 'https://api.github.com/users/keyber-inc/subscriptions',
  'organizations_url': 'https://api.github.com/users/keyber-inc/orgs',
  'repos_url': 'https://api.github.com/users/keyber-inc/repos',
  'events_url': 'https://api.github.com/users/keyber-inc/events{/privacy}',
  'received_events_url':
      'https://api.github.com/users/keyber-inc/received_events',
  'type': 'Organization',
  'site_admin': false,
};

/// license json map
const licenseJsonMap = {
  'key': 'mit',
  'name': 'MIT License',
  'spdx_id': 'MIT',
  'url': 'https://api.github.com/licenses/mit',
  'node_id': 'MDc6TGljZW5zZTEz',
};

/// permissions json map
const permissionsJsonMap = {
  'admin': false,
  'maintain': false,
  'push': false,
  'triage': false,
  'pull': true
};

/// repo json map
const repoJsonMap1 = {
  'id': 472553415,
  'node_id': 'R_kgDOHCqXxw',
  'name': 'github_search',
  'full_name': 'keyber-inc/github_search',
  'private': false,
  'owner': ownerJsonMap,
  'html_url': 'https://github.com/keyber-inc/github_search',
  'description': 'Search Github repositories.',
  'fork': false,
  'url': 'https://api.github.com/repos/keyber-inc/github_search',
  'forks_url': 'https://api.github.com/repos/keyber-inc/github_search/forks',
  'keys_url':
      'https://api.github.com/repos/keyber-inc/github_search/keys{/key_id}',
  'collaborators_url':
      'https://api.github.com/repos/keyber-inc/github_search/collaborators{/collaborator}',
  'teams_url': 'https://api.github.com/repos/keyber-inc/github_search/teams',
  'hooks_url': 'https://api.github.com/repos/keyber-inc/github_search/hooks',
  'issue_events_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues/events{/number}',
  'events_url': 'https://api.github.com/repos/keyber-inc/github_search/events',
  'assignees_url':
      'https://api.github.com/repos/keyber-inc/github_search/assignees{/user}',
  'branches_url':
      'https://api.github.com/repos/keyber-inc/github_search/branches{/branch}',
  'tags_url': 'https://api.github.com/repos/keyber-inc/github_search/tags',
  'blobs_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/blobs{/sha}',
  'git_tags_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/tags{/sha}',
  'git_refs_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/refs{/sha}',
  'trees_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/trees{/sha}',
  'statuses_url':
      'https://api.github.com/repos/keyber-inc/github_search/statuses/{sha}',
  'languages_url':
      'https://api.github.com/repos/keyber-inc/github_search/languages',
  'stargazers_url':
      'https://api.github.com/repos/keyber-inc/github_search/stargazers',
  'contributors_url':
      'https://api.github.com/repos/keyber-inc/github_search/contributors',
  'subscribers_url':
      'https://api.github.com/repos/keyber-inc/github_search/subscribers',
  'subscription_url':
      'https://api.github.com/repos/keyber-inc/github_search/subscription',
  'commits_url':
      'https://api.github.com/repos/keyber-inc/github_search/commits{/sha}',
  'git_commits_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/commits{/sha}',
  'comments_url':
      'https://api.github.com/repos/keyber-inc/github_search/comments{/number}',
  'issue_comment_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues/comments{/number}',
  'contents_url':
      'https://api.github.com/repos/keyber-inc/github_search/contents/{+path}',
  'compare_url':
      'https://api.github.com/repos/keyber-inc/github_search/compare/{base}...{head}',
  'merges_url': 'https://api.github.com/repos/keyber-inc/github_search/merges',
  'archive_url':
      'https://api.github.com/repos/keyber-inc/github_search/{archive_format}{/ref}',
  'downloads_url':
      'https://api.github.com/repos/keyber-inc/github_search/downloads',
  'issues_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues{/number}',
  'pulls_url':
      'https://api.github.com/repos/keyber-inc/github_search/pulls{/number}',
  'milestones_url':
      'https://api.github.com/repos/keyber-inc/github_search/milestones{/number}',
  'notifications_url':
      'https://api.github.com/repos/keyber-inc/github_search/notifications{?since,all,participating}',
  'labels_url':
      'https://api.github.com/repos/keyber-inc/github_search/labels{/name}',
  'releases_url':
      'https://api.github.com/repos/keyber-inc/github_search/releases{/id}',
  'deployments_url':
      'https://api.github.com/repos/keyber-inc/github_search/deployments',
  'created_at': '2022-03-22T00:01:16Z',
  'updated_at': '2022-03-22T09:09:38Z',
  'pushed_at': '2022-03-25T03:59:07Z',
  'git_url': 'git://github.com/keyber-inc/github_search.git',
  'ssh_url': 'git@github.com:keyber-inc/github_search.git',
  'clone_url': 'https://github.com/keyber-inc/github_search.git',
  'svn_url': 'https://github.com/keyber-inc/github_search',
  'homepage': null,
  'size': 5081,
  'stargazers_count': 1,
  'watchers_count': 1,
  'language': 'C++',
  'has_issues': true,
  'has_projects': true,
  'has_downloads': true,
  'has_wiki': true,
  'has_pages': false,
  'forks_count': 0,
  'mirror_url': null,
  'archived': false,
  'disabled': false,
  'open_issues_count': 2,
  'license': licenseJsonMap,
  'allow_forking': true,
  'is_template': false,
  'topics': <String>[],
  'visibility': 'public',
  'forks': 0,
  'open_issues': 2,
  'watchers': 1,
  'default_branch': 'develop',
  'permissions': permissionsJsonMap,
  'temp_clone_token': '',
  'network_count': 0,
  'subscribers_count': 1,
};

/// repo json map
const repoJsonMap2 = {
  'id': 472553415,
  'node_id': 'R_kgDOHCqXxw',
  'name': 'github_search2',
  'full_name': 'keyber-inc/github_search2',
  'private': false,
  'owner': ownerJsonMap,
  'html_url': 'https://github.com/keyber-inc/github_search',
  'description': 'Search Github repositories.',
  'fork': false,
  'url': 'https://api.github.com/repos/keyber-inc/github_search',
  'forks_url': 'https://api.github.com/repos/keyber-inc/github_search/forks',
  'keys_url':
      'https://api.github.com/repos/keyber-inc/github_search/keys{/key_id}',
  'collaborators_url':
      'https://api.github.com/repos/keyber-inc/github_search/collaborators{/collaborator}',
  'teams_url': 'https://api.github.com/repos/keyber-inc/github_search/teams',
  'hooks_url': 'https://api.github.com/repos/keyber-inc/github_search/hooks',
  'issue_events_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues/events{/number}',
  'events_url': 'https://api.github.com/repos/keyber-inc/github_search/events',
  'assignees_url':
      'https://api.github.com/repos/keyber-inc/github_search/assignees{/user}',
  'branches_url':
      'https://api.github.com/repos/keyber-inc/github_search/branches{/branch}',
  'tags_url': 'https://api.github.com/repos/keyber-inc/github_search/tags',
  'blobs_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/blobs{/sha}',
  'git_tags_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/tags{/sha}',
  'git_refs_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/refs{/sha}',
  'trees_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/trees{/sha}',
  'statuses_url':
      'https://api.github.com/repos/keyber-inc/github_search/statuses/{sha}',
  'languages_url':
      'https://api.github.com/repos/keyber-inc/github_search/languages',
  'stargazers_url':
      'https://api.github.com/repos/keyber-inc/github_search/stargazers',
  'contributors_url':
      'https://api.github.com/repos/keyber-inc/github_search/contributors',
  'subscribers_url':
      'https://api.github.com/repos/keyber-inc/github_search/subscribers',
  'subscription_url':
      'https://api.github.com/repos/keyber-inc/github_search/subscription',
  'commits_url':
      'https://api.github.com/repos/keyber-inc/github_search/commits{/sha}',
  'git_commits_url':
      'https://api.github.com/repos/keyber-inc/github_search/git/commits{/sha}',
  'comments_url':
      'https://api.github.com/repos/keyber-inc/github_search/comments{/number}',
  'issue_comment_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues/comments{/number}',
  'contents_url':
      'https://api.github.com/repos/keyber-inc/github_search/contents/{+path}',
  'compare_url':
      'https://api.github.com/repos/keyber-inc/github_search/compare/{base}...{head}',
  'merges_url': 'https://api.github.com/repos/keyber-inc/github_search/merges',
  'archive_url':
      'https://api.github.com/repos/keyber-inc/github_search/{archive_format}{/ref}',
  'downloads_url':
      'https://api.github.com/repos/keyber-inc/github_search/downloads',
  'issues_url':
      'https://api.github.com/repos/keyber-inc/github_search/issues{/number}',
  'pulls_url':
      'https://api.github.com/repos/keyber-inc/github_search/pulls{/number}',
  'milestones_url':
      'https://api.github.com/repos/keyber-inc/github_search/milestones{/number}',
  'notifications_url':
      'https://api.github.com/repos/keyber-inc/github_search/notifications{?since,all,participating}',
  'labels_url':
      'https://api.github.com/repos/keyber-inc/github_search/labels{/name}',
  'releases_url':
      'https://api.github.com/repos/keyber-inc/github_search/releases{/id}',
  'deployments_url':
      'https://api.github.com/repos/keyber-inc/github_search/deployments',
  'created_at': '2022-03-22T00:01:16Z',
  'updated_at': '2022-03-22T09:09:38Z',
  'pushed_at': '2022-03-25T03:59:07Z',
  'git_url': 'git://github.com/keyber-inc/github_search.git',
  'ssh_url': 'git@github.com:keyber-inc/github_search.git',
  'clone_url': 'https://github.com/keyber-inc/github_search.git',
  'svn_url': 'https://github.com/keyber-inc/github_search',
  'homepage': null,
  'size': 5081,
  'stargazers_count': 1,
  'watchers_count': 1,
  'language': 'C++',
  'has_issues': true,
  'has_projects': true,
  'has_downloads': true,
  'has_wiki': true,
  'has_pages': false,
  'forks_count': 0,
  'mirror_url': null,
  'archived': false,
  'disabled': false,
  'open_issues_count': 2,
  'license': licenseJsonMap,
  'allow_forking': true,
  'is_template': false,
  'topics': <String>[],
  'visibility': 'public',
  'forks': 0,
  'open_issues': 2,
  'watchers': 1,
  'default_branch': 'develop',
  'permissions': permissionsJsonMap,
  'temp_clone_token': '',
  'network_count': 0,
  'subscribers_count': 1,
};

/// searchReposResult json map
const searchReposResultJsonMap1 = {
  'total_count': 1,
  'incomplete_results': false,
  'items': [
    repoJsonMap1,
  ],
};

/// searchReposResult json map
const searchReposResultJsonMap2 = {
  'total_count': 1,
  'incomplete_results': false,
  'items': [
    repoJsonMap2,
  ],
};

/// モック版のHTTPクライアント
final mockHttpClient = MockClient(
  (request) async {
    switch (request.url.path) {
      case '/search/repositories':
        final query = request.url.queryParameters['q'];
        if (query == 'initialSearchText') {
          return http.Response(json.encode(searchReposResultJsonMap1), 200);
        }
        return http.Response(json.encode(searchReposResultJsonMap2), 200);

      case '/repos/keyber-inc/github_search':
        return http.Response(json.encode(repoJsonMap1), 200);
      case 'owner':
        return http.Response(json.encode(ownerJsonMap), 200);
      case '400':
        return http.Response('400', 400);
      case '401':
        return http.Response('401', 401);
      case '403':
        return http.Response('403', 403);
      case '404':
        return http.Response('404', 404);
      case '422':
        return http.Response('422', 422);
      case '503':
        return http.Response('503', 503);
      case '555':
        return http.Response('555', 555);
      case 'socketException':
        throw const SocketException('');
    }
    return http.Response('', 404);
  },
);

/// モック版のGithubHttpClient
final mockGithubHttpClient =
    GithubHttpClient(token: 'dummy', client: mockHttpClient);
