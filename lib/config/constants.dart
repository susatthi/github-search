// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// GitHub API を使うためのOAuthトークンのキー
/// --dart-defineで指定する
/// 例: flutter run --dart-define GITHUB_OAUTH_TOKEN=YOUR_OAUTH_TOKEN
const kDartDefineKeyGitHubOAuthToken = 'GITHUB_OAUTH_TOKEN';

/// 検索文字列のデフォルト値のキー
/// --dart-defineで指定する
/// 例: flutter run --dart-define DEFAULT_SEARCH_VALUE=YOUR_SEARCH_VALUE
const kDartDefineKeyDefaultSearchValue = 'DEFAULT_SEARCH_VALUE';

/// 画面遷移時に渡すパラメータのキー
const kPageParamKeyOwnerName = 'owner_name';
const kPageParamKeyRepoName = 'repo_name';
