// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// 環境変数
/// `env.dart` にリネームして使うこと
class Env {
  /// Github API を使うためのOAuthトークン
  /// --dart-defineで指定することも可能
  /// 例: flutter run --dart-define GITHUB_OAUTH_TOKEN=YOUR_OAUTH_TOKEN
  static const githubOAuthToken = 'YOUR_OAUTH_TOKEN';
}
