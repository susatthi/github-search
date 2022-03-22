// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:github_search/repository/dataSource/github/api_exception.dart';
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
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await _client.get(uri, headers: _headers);
      switch (response.statusCode) {
        case 200:
          final dynamic data = json.decode(response.body);
          return builder(data);
        case 400:
          throw GithubApiException.badRequest();
        case 401:
          throw GithubApiException.badCredentials();
        case 403:
          throw GithubApiException.maximumNumberOfLoginAttemptsExceeded();
        case 422:
          throw GithubApiException.validationFailed();
        case 503:
          throw GithubApiException.serviceUnavailable();
        default:
          throw GithubApiException.unknown();
      }
    } on SocketException catch (_) {
      throw GithubApiException.noInternetConnection();
    }
  }
}
