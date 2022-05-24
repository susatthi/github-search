// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/owner/owner.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/repositories/github/exception.dart';
import 'package:github_search/repositories/github/http_client.dart';

import '../../test_utils/locale.dart';
import '../../test_utils/mocks.dart';

void main() {
  late GitHubHttpClient client;
  setUp(() {
    client = mockProviderContainer().read(githubHttpClientProvider);
    useEnvironmentLocale();
  });
  test('githubAccessTokenProvider', () async {
    final container = ProviderContainer();
    final token = container.read(githubAccessTokenProvider);
    expect(token, isNotNull);
  });
  test('httpClientProvider', () async {
    final container = ProviderContainer();
    final httpClient = container.read(httpClientProvider);
    expect(httpClient, isNotNull);
  });
  group('GitHubHttpClient.get()', () {
    test('200 OK', () async {
      final repo = await client.get<Repo>(
        uri: Uri.parse('https://api.github.com/repos/flutter/flutter'),
        responseBuilder: Repo.fromJson,
      );
      expect(repo, isNotNull);
    });
    test('400 BadRequest', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '400'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeBadRequest);
      }
    });
    test('401 BadCredentials', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '401'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeBadCredentials);
      }
    });
    test('403 MaximumNumberOfLoginAttemptsExceeded', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '403'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(
          e.code,
          GitHubException.codeMaximumNumberOfLoginAttemptsExceeded,
        );
      }
    });
    test('404 NotFound', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '404'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeNotFound);
      }
    });
    test('422 ValidationFailed', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '422'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeValidationFailed);
      }
    });
    test('503 ServiceUnavailable', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '503'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeServiceUnavailable);
      }
    });
    test('Unknown', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: '555'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeUnknown);
      }
    });
    test('NoInternetConnection', () async {
      try {
        await client.get<Owner>(
          uri: Uri(path: 'socketException'),
          responseBuilder: Owner.fromJson,
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeNoInternetConnection);
      }
    });
  });
  group('GitHubHttpClient.getRaw()', () {
    test('200 OK', () async {
      final body = await client.getRaw(
        uri: Uri.parse(
          'https://raw.githubusercontent.com/flutter/flutter/master/README.md',
        ),
      );
      expect(body, isNotNull);
    });
    test('400 BadRequest', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '400'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeBadRequest);
      }
    });
    test('401 BadCredentials', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '401'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeUnknown);
      }
    });
    test('403 MaximumNumberOfLoginAttemptsExceeded', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '403'),
        );
      } on GitHubException catch (e) {
        expect(
          e.code,
          GitHubException.codeUnknown,
        );
      }
    });
    test('404 NotFound', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '404'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeNotFound);
      }
    });
    test('422 ValidationFailed', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '422'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeUnknown);
      }
    });
    test('503 ServiceUnavailable', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '503'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeServiceUnavailable);
      }
    });
    test('Unknown', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '555'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeUnknown);
      }
    });
    test('NoInternetConnection', () async {
      try {
        await client.getRaw(
          uri: Uri(path: 'socketException'),
        );
      } on GitHubException catch (e) {
        expect(e.code, GitHubException.codeNoInternetConnection);
      }
    });
  });
}
