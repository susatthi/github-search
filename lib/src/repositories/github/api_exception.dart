// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// Github API の例外
class GithubApiException implements Exception {
  const GithubApiException([
    this.message,
    this.code,
  ]);

  /// 1. 無効なJSONを送信すると、`400 Bad Request` レスポンスが返されます。
  /// 2. 間違ったタイプの JSON 値を送信すると、`400 Bad Request` レスポンスが返されます。
  factory GithubApiException.badRequest() => const GithubApiException(
        'Illegal request sent. (400)',
        GithubApiExceptionCode.badRequest,
      );

  /// 無効な認証情報で認証すると、`401 Unauthorized` が返されます。
  factory GithubApiException.badCredentials() => const GithubApiException(
        'Illegal request sent. (401)',
        GithubApiExceptionCode.badCredentials,
      );

  /// API は、無効な認証情報を含むリクエストを短期間に複数回検出すると、`403 Forbidden` で、
  /// そのユーザに対するすべての認証試行（有効な認証情報を含む）を一時的に拒否します。
  factory GithubApiException.maximumNumberOfLoginAttemptsExceeded() =>
      const GithubApiException(
        'Please wait a while and try again. (403)',
        GithubApiExceptionCode.maximumNumberOfLoginAttemptsExceeded,
      );

  /// `404 Not Found`
  factory GithubApiException.notFound() => const GithubApiException(
        'No data found. (404)',
        GithubApiExceptionCode.notFound,
      );

  /// 無効なフィールドを送信すると、`422 Unprocessable Entity` レスポンスが返されます。
  factory GithubApiException.validationFailed() => const GithubApiException(
        'Illegal request sent. (422)',
        GithubApiExceptionCode.validationFailed,
      );

  /// `503 Service Unavailable` サービス停止中
  factory GithubApiException.serviceUnavailable() => const GithubApiException(
        'Please wait a while and try again.  (503)',
        GithubApiExceptionCode.serviceUnavailable,
      );

  /// 不明なエラー
  factory GithubApiException.unknown() => const GithubApiException(
        'An unknown error has occurred. (-1)',
        GithubApiExceptionCode.unknown,
      );

  /// インターネット接続不可
  factory GithubApiException.noInternetConnection() => const GithubApiException(
        'Please try again in a good communication environment. (-2)',
        GithubApiExceptionCode.noInternetConnection,
      );

  /// メッセージ
  final dynamic message;

  /// エラーコード
  final GithubApiExceptionCode? code;

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) {
      return 'GithubApiException';
    }
    return 'GithubApiException: $message';
  }
}

/// Github API のエラーコード
enum GithubApiExceptionCode {
  badRequest,
  badCredentials,
  maximumNumberOfLoginAttemptsExceeded,
  notFound,
  validationFailed,
  serviceUnavailable,
  unknown,
  noInternetConnection,
}
