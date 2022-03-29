// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/owner/owner.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/repositories/github/exception.dart';

import '../../test_utils/mocks.dart';

void main() {
  group('get()', () {
    test('200 OK', () async {
      final repo = await mockGithubHttpClient.get<Repo>(
        uri: Uri(path: '/repos/flutter/flutter'),
        responseBuilder: Repo.fromJson,
      );
      expect(repo, isNotNull);
    });
    test('400 BadRequest', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '400'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeBadRequest);
      }
    });
    test('401 BadCredentials', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '401'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeBadCredentials);
      }
    });
    test('403 MaximumNumberOfLoginAttemptsExceeded', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '403'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(
          e.code,
          GithubException.codeMaximumNumberOfLoginAttemptsExceeded,
        );
      }
    });
    test('404 NotFound', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '404'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeNotFound);
      }
    });
    test('422 ValidationFailed', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '422'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeValidationFailed);
      }
    });
    test('503 ServiceUnavailable', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '503'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeServiceUnavailable);
      }
    });
    test('Unknown', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: '555'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeUnknown);
      }
    });
    test('NoInternetConnection', () async {
      try {
        await mockGithubHttpClient.get<Owner>(
          uri: Uri(path: 'socketException'),
          responseBuilder: Owner.fromJson,
        );
      } on GithubException catch (e) {
        expect(e.code, GithubException.codeNoInternetConnection);
      }
    });
  });
}
