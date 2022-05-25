// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/env.dart';
import '../../config/env_define.dart';
import '../../utils/logger.dart';
import 'exception.dart';

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
  (ref) {
    final token = ref.watch(githubAccessTokenProvider);
    final client = ref.watch(httpClientProvider);
    return GitHubHttpClient(
      token: token,
      client: client,
    );
  },
);

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

  /// GET Raw Request
  Future<String> getRaw({
    required Uri uri,
  }) async {
    try {
      logger.i('request: uri=$uri');
      final response = await _client.get(uri);
      logger.i(
        'response: statusCode=${response.statusCode}, '
        'contentLength=${response.contentLength}',
      );
      switch (response.statusCode) {
        case 200:
          return response.body;
        case 400:
          throw GitHubException.badRequest();
        case 404:
          throw GitHubException.notFound();
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
