// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

/// 基底ドメイン例外
///
/// ドメイン層が定義する例外の基底クラス
abstract class DomainException implements Exception {
  const DomainException(this.message);

  final Object message;
}

/// ドメイン層で発生する入力値検査例外
class ValidatorException extends DomainException {
  const ValidatorException._([
    super.message = 'validator exception',
    String? code,
    this.target,
  ]) : code = code ?? codeUnknown;

  /// 引数が不正
  factory ValidatorException.invalidArgument([String? target]) =>
      ValidatorException._(
        'Invalid argument',
        codeInvalidArgument,
        target,
      );

  // エラーコードの定義
  static const codeInvalidArgument = 'invalid-argument';
  static const codeUnknown = 'unknown';

  /// エラーコード
  final String code;

  /// 対象
  final String? target;

  @override
  String toString() => 'ValidatorException: $message';
}

/// インフラストラクチャ層で発生するネットワーク関連の例外
///
/// リポジトリ実装がこの例外を投げたら、プレゼンテーション層
/// で受け取って適切に表示すること。
class NetworkException extends DomainException {
  const NetworkException._([
    super.message = 'network exception',
    String? code,
  ]) : code = code ?? codeUnknown;

  /// 1. 無効なJSONを送信すると、`400 Bad Request` レスポンスが返されます。
  /// 2. 間違ったタイプの JSON 値を送信すると、`400 Bad Request` レスポンスが返されます。
  factory NetworkException.badRequest() => const NetworkException._(
        'Illegal request sent. (400)',
        codeBadRequest,
      );

  /// 無効な認証情報で認証すると、`401 Unauthorized` が返されます。
  factory NetworkException.badCredentials() => const NetworkException._(
        'Illegal request sent. (401)',
        codeBadCredentials,
      );

  /// API は、無効な認証情報を含むリクエストを短期間に複数回検出すると、`403 Forbidden` で、
  /// そのユーザに対するすべての認証試行（有効な認証情報を含む）を一時的に拒否します。
  factory NetworkException.maximumNumberOfLoginAttemptsExceeded() =>
      const NetworkException._(
        'Please wait a while and try again. (403)',
        codeMaximumNumberOfLoginAttemptsExceeded,
      );

  /// `404 Not Found`
  factory NetworkException.notFound() => const NetworkException._(
        'No data found. (404)',
        codeNotFound,
      );

  /// 無効なフィールドを送信すると、`422 Unprocessable Entity` レスポンスが返されます。
  factory NetworkException.validationFailed() => const NetworkException._(
        'Illegal request sent. (422)',
        codeValidationFailed,
      );

  /// `503 Service Unavailable` サービス停止中
  factory NetworkException.serviceUnavailable() => const NetworkException._(
        'Please wait a while and try again.  (503)',
        codeServiceUnavailable,
      );

  /// インターネット接続不可
  factory NetworkException.noInternetConnection() => const NetworkException._(
        'Please try again in a good communication environment. (-2)',
        codeNoInternetConnection,
      );

  /// 不明なエラー
  factory NetworkException.unknown() => const NetworkException._(
        'An unknown error has occurred. (-1)',
        codeUnknown,
      );

  // エラーコードの定義
  static const codeBadRequest = 'bad-request';
  static const codeBadCredentials = 'bad-credentials';
  static const codeMaximumNumberOfLoginAttemptsExceeded =
      'maximum-number-of-login-attempts-exceeded';
  static const codeNotFound = 'not-found';
  static const codeValidationFailed = 'validation-failed';
  static const codeServiceUnavailable = 'service-unavailable';
  static const codeNoInternetConnection = 'no-internet-connection';
  static const codeUnknown = 'unknown';

  /// エラーコード
  final String code;

  @override
  String toString() => 'NetworkException[$code]: $message';
}
