// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// GitHub API の例外
class GitHubException implements Exception {
  const GitHubException([
    this.message,
    String? code,
    // ignore: unnecessary_this
  ]) : this.code = code ?? codeUnknown;

  /// 1. 無効なJSONを送信すると、`400 Bad Request` レスポンスが返されます。
  /// 2. 間違ったタイプの JSON 値を送信すると、`400 Bad Request` レスポンスが返されます。
  factory GitHubException.badRequest() => const GitHubException(
        'Illegal request sent. (400)',
        codeBadRequest,
      );

  /// 無効な認証情報で認証すると、`401 Unauthorized` が返されます。
  factory GitHubException.badCredentials() => const GitHubException(
        'Illegal request sent. (401)',
        codeBadCredentials,
      );

  /// API は、無効な認証情報を含むリクエストを短期間に複数回検出すると、`403 Forbidden` で、
  /// そのユーザに対するすべての認証試行（有効な認証情報を含む）を一時的に拒否します。
  factory GitHubException.maximumNumberOfLoginAttemptsExceeded() =>
      const GitHubException(
        'Please wait a while and try again. (403)',
        codeMaximumNumberOfLoginAttemptsExceeded,
      );

  /// `404 Not Found`
  factory GitHubException.notFound() => const GitHubException(
        'No data found. (404)',
        codeNotFound,
      );

  /// 無効なフィールドを送信すると、`422 Unprocessable Entity` レスポンスが返されます。
  factory GitHubException.validationFailed() => const GitHubException(
        'Illegal request sent. (422)',
        codeValidationFailed,
      );

  /// `503 Service Unavailable` サービス停止中
  factory GitHubException.serviceUnavailable() => const GitHubException(
        'Please wait a while and try again.  (503)',
        codeServiceUnavailable,
      );

  /// 不明なエラー
  factory GitHubException.unknown() => const GitHubException(
        'An unknown error has occurred. (-1)',
        codeUnknown,
      );

  /// インターネット接続不可
  factory GitHubException.noInternetConnection() => const GitHubException(
        'Please try again in a good communication environment. (-2)',
        codeNoInternetConnection,
      );

  // エラーコードの定義
  static const codeBadRequest = 'bad-request';
  static const codeBadCredentials = 'bad-credentials';
  static const codeMaximumNumberOfLoginAttemptsExceeded =
      'maximum-number-of-login-attempts-exceeded';
  static const codeNotFound = 'not-found';
  static const codeValidationFailed = 'validation-failed';
  static const codeServiceUnavailable = 'service-unavailable';
  static const codeUnknown = 'unknown';
  static const codeNoInternetConnection = 'no-internet-connection';

  /// メッセージ
  final dynamic message;

  /// エラーコード
  final String code;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! GitHubException) {
      return false;
    }
    return other.hashCode == hashCode;
  }

  @override
  int get hashCode => hashValues(code, message);

  @override
  String toString() {
    final Object? message = this.message;
    if (message == null) {
      return 'GitHubException[$code]';
    }
    return 'GitHubException[$code]: $message';
  }
}
