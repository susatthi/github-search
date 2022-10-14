// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../domain/exceptions.dart';
import '../../utils/env/env.dart';
import '../../utils/env/env_define.dart';
import '../../utils/logger.dart';

/// GitHubアクセストークンプロバイダー
final githubAccessTokenProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyGitHubAccessToken,
    defaultValue: Env.gitHubAccessToken,
  ),
);

/// HTTPクライアントプロバイダー
final httpClientProvider = Provider<http.Client>(
  (ref) => http.Client(),
);

/// GitHub API 用の HTTPクライアントプロバイダー
final githubHttpClientProvider = Provider<GitHubHttpClient>(
  (ref) => GitHubHttpClient(
    token: ref.watch(githubAccessTokenProvider),
    client: ref.watch(httpClientProvider),
  ),
);

/// GitHub API 用の HTTPクライアント
class GitHubHttpClient {
  const GitHubHttpClient({
    required this.token,
    required this.client,
  });

  /// アクセストークン
  final String token;

  /// HTTPクライアント
  final http.Client client;

  /// 共通ヘッダを返す
  Map<String, String> get _headers => <String, String>{
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $token',
      };

  /// GET Request
  Future<T> get<T>({
    required Uri uri,
    required T Function(Map<String, dynamic> data) responseBuilder,
  }) async {
    try {
      logger.i('Get request: uri = $uri');
      final response = await client.get(uri, headers: _headers);
      logger.i(
        'Get response: code = ${response.statusCode}, '
        'length = ${response.contentLength}',
      );
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body) as Map<String, dynamic>;
          return responseBuilder(data);
        case 400:
          throw NetworkException.badRequest();
        case 401:
          throw NetworkException.badCredentials();
        case 403:
          throw NetworkException.maximumNumberOfLoginAttemptsExceeded();
        case 404:
          throw NetworkException.notFound();
        case 422:
          throw NetworkException.validationFailed();
        case 503:
          throw NetworkException.serviceUnavailable();
        default:
          throw NetworkException.unknown();
      }
    } on SocketException catch (e) {
      logger.w(e);
      throw NetworkException.noInternetConnection();
    }
  }

  /// GET Raw Request
  Future<String> getRaw({
    required Uri uri,
  }) async {
    try {
      logger.i('Get raw request: uri = $uri');
      final response = await client.get(uri);
      logger.i(
        'Get raw response: code = ${response.statusCode}, '
        'length = ${response.contentLength}',
      );
      switch (response.statusCode) {
        case 200:
          return response.body;
        case 400:
          throw NetworkException.badRequest();
        case 404:
          throw NetworkException.notFound();
        case 503:
          throw NetworkException.serviceUnavailable();
        default:
          throw NetworkException.unknown();
      }
    } on SocketException catch (e) {
      logger.w(e);
      throw NetworkException.noInternetConnection();
    }
  }
}
