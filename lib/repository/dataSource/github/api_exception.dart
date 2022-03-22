// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// Github API の例外
class GithubApiException implements Exception {
  const GithubApiException([this.message]);

  /// 1. 無効なJSONを送信すると、`400 Bad Request` レスポンスが返されます。
  /// 2. 間違ったタイプの JSON 値を送信すると、`400 Bad Request` レスポンスが返されます。
  factory GithubApiException.badRequest() =>
      const GithubApiException('不正なリクエストが送信されました。(BadRequest)');

  /// 無効な認証情報で認証すると、`401 Unauthorized` が返されます。
  factory GithubApiException.badCredentials() =>
      const GithubApiException('不正なリクエストが送信されました。(BadCredentials)');

  /// API は、無効な認証情報を含むリクエストを短期間に複数回検出すると、`403 Forbidden` で、
  /// そのユーザに対するすべての認証試行（有効な認証情報を含む）を一時的に拒否します。
  factory GithubApiException.maximumNumberOfLoginAttemptsExceeded() =>
      const GithubApiException(
        'しばらく時間をおいてから再度お試しください。(MaximumNumberOfLoginAttemptsExceeded)',
      );

  /// 無効なフィールドを送信すると、`422 Unprocessable Entity` レスポンスが返されます。
  factory GithubApiException.validationFailed() =>
      const GithubApiException('不正なリクエストが送信されました。(ValidationFailed)');

  /// `503 Service Unavailable` サービス停止中
  factory GithubApiException.serviceUnavailable() =>
      const GithubApiException('しばらく時間をおいてから再度お試しください。(ServiceUnavailable)');

  /// 不明なエラー
  factory GithubApiException.unknown() =>
      const GithubApiException('不明なエラーが発生しました。(Unknown)');

  /// インターネット接続不可
  factory GithubApiException.noInternetConnection() =>
      const GithubApiException('通信環境の良いところで再度お試しください。(NoInternetConnection)');

  final dynamic message;

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) {
      return 'GithubApiException';
    }
    return '$message';
  }
}
