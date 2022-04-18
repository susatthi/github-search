// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github_search/repositories/github/exception.dart';
import 'package:github_search/utils/logger.dart';
import 'package:http/http.dart' as http;

/// GitHub API 用の HTTPクライアント
class GitHubHttpClient {
  const GitHubHttpClient({
    required String token,
    required http.Client client,
  })  : _token = token,
        _client = client;

  /// アクセストークン
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
      logger.i('request: uri=$uri');
      final response = await _client.get(uri, headers: _headers);
      logger.i(
        'response: statusCode=${response.statusCode}, '
        'contentLength=${response.contentLength}',
      );
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body) as Map<String, dynamic>;
          return responseBuilder(data);
        case 400:
          throw GitHubException.badRequest();
        case 401:
          throw GitHubException.badCredentials();
        case 403:
          throw GitHubException.maximumNumberOfLoginAttemptsExceeded();
        case 404:
          throw GitHubException.notFound();
        case 422:
          throw GitHubException.validationFailed();
        case 503:
          throw GitHubException.serviceUnavailable();
        default:
          throw GitHubException.unknown();
      }
    } on SocketException catch (e) {
      logger.w(e);
      throw GitHubException.noInternetConnection();
    }
  }
}
