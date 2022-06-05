// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/exceptions.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/json_objects/owner.dart';
import 'package:github_search/infrastructure/github/json_objects/repo.dart';

import '../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  late GitHubHttpClient client;
  setUp(() async {
    await agent.setUp();
    client = agent.mockContainer().read(githubHttpClientProvider);
  });
  tearDown(agent.tearDown);

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
      final repo = await client.get<RepoJsonObject>(
        uri: Uri.parse('https://api.github.com/repos/flutter/flutter'),
        responseBuilder: RepoJsonObject.fromJson,
      );
      expect(repo, isNotNull);
    });
    test('400 BadRequest', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '400'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeBadRequest);
      }
    });
    test('401 BadCredentials', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '401'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeBadCredentials);
      }
    });
    test('403 MaximumNumberOfLoginAttemptsExceeded', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '403'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(
          e.code,
          NetworkException.codeMaximumNumberOfLoginAttemptsExceeded,
        );
      }
    });
    test('404 NotFound', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '404'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeNotFound);
      }
    });
    test('422 ValidationFailed', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '422'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeValidationFailed);
      }
    });
    test('503 ServiceUnavailable', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '503'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeServiceUnavailable);
      }
    });
    test('Unknown', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: '555'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeUnknown);
      }
    });
    test('NoInternetConnection', () async {
      try {
        await client.get<OwnerJsonObject>(
          uri: Uri(path: 'socketException'),
          responseBuilder: OwnerJsonObject.fromJson,
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeNoInternetConnection);
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
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeBadRequest);
      }
    });
    test('401 BadCredentials', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '401'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeUnknown);
      }
    });
    test('403 MaximumNumberOfLoginAttemptsExceeded', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '403'),
        );
      } on NetworkException catch (e) {
        expect(
          e.code,
          NetworkException.codeUnknown,
        );
      }
    });
    test('404 NotFound', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '404'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeNotFound);
      }
    });
    test('422 ValidationFailed', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '422'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeUnknown);
      }
    });
    test('503 ServiceUnavailable', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '503'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeServiceUnavailable);
      }
    });
    test('Unknown', () async {
      try {
        await client.getRaw(
          uri: Uri(path: '555'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeUnknown);
      }
    });
    test('NoInternetConnection', () async {
      try {
        await client.getRaw(
          uri: Uri(path: 'socketException'),
        );
      } on NetworkException catch (e) {
        expect(e.code, NetworkException.codeNoInternetConnection);
      }
    });
  });
}
