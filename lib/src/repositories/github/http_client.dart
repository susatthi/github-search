// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github_search/src/repositories/github/exception.dart';
import 'package:github_search/src/utils/logger.dart';
import 'package:http/http.dart' as http;

/// Github API 用の HTTPクライアント
class GithubHttpClient {
  const GithubHttpClient({
    required String token,
    required http.Client client,
  })  : _token = token,
        _client = client;

  /// OAuthトークン
  final String _token;

  /// HTTPクライアント
  final http.Client _client;

  /// 共通ヘッダを返す
  Map<String, String> get _headers => <String, String>{
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $_token',
      };

  /// GET Request
  Future<T> get<T>({
    required Uri uri,
    required T Function(Map<String, dynamic> data) responseBuilder,
  }) async {
    try {
      logger.info('request: uri=$uri');
      final response = await _client.get(uri, headers: _headers);
      logger.info(
        'response: statusCode=${response.statusCode}, '
        'contentLength=${response.contentLength}',
      );
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body) as Map<String, dynamic>;
          return responseBuilder(data);
        case 400:
          throw GithubException.badRequest();
        case 401:
          throw GithubException.badCredentials();
        case 403:
          throw GithubException.maximumNumberOfLoginAttemptsExceeded();
        case 404:
          throw GithubException.notFound();
        case 422:
          throw GithubException.validationFailed();
        case 503:
          throw GithubException.serviceUnavailable();
        default:
          throw GithubException.unknown();
      }
    } on SocketException catch (e) {
      logger.warning(e);
      throw GithubException.noInternetConnection();
    }
  }
}
