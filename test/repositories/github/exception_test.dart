// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/github/exception.dart';

void main() {
  group('コンストラクタ', () {
    test('生成出来るはず', () {
      expect(const GitHubException(), isNotNull);
      expect(const GitHubException('dummy'), isNotNull);
      expect(const GitHubException('dummy', 'code'), isNotNull);
    });
  });
  group('factories', () {
    test('badRequestが生成出来るはず', () {
      final e = GitHubException.badRequest();
      expect(e.code, 'bad-request');
    });
    test('badCredentialsが生成出来るはず', () {
      final e = GitHubException.badCredentials();
      expect(e.code, 'bad-credentials');
    });
    test('maximumNumberOfLoginAttemptsExceededが生成出来るはず', () {
      final e = GitHubException.maximumNumberOfLoginAttemptsExceeded();
      expect(e.code, 'maximum-number-of-login-attempts-exceeded');
    });
    test('notFoundが生成出来るはず', () {
      final e = GitHubException.notFound();
      expect(e.code, 'not-found');
    });
    test('validationFailedが生成出来るはず', () {
      final e = GitHubException.validationFailed();
      expect(e.code, 'validation-failed');
    });
    test('serviceUnavailableが生成出来るはず', () {
      final e = GitHubException.serviceUnavailable();
      expect(e.code, 'service-unavailable');
    });
    test('unknownが生成出来るはず', () {
      final e = GitHubException.unknown();
      expect(e.code, 'unknown');
    });
    test('noInternetConnectionが生成出来るはず', () {
      final e = GitHubException.noInternetConnection();
      expect(e.code, 'no-internet-connection');
    });
  });
  group('operator ==', () {
    test('一致するはず', () {
      final e1 = GitHubException.badRequest();
      final e2 = GitHubException.badRequest();
      expect(e1 == e2, true);
    });
    test('一致しないはず', () {
      final e1 = GitHubException.badRequest();
      final e2 = GitHubException.badCredentials();
      expect(e1 == e2, false);

      const e3 = GitHubException(
        'foo',
        GitHubException.codeBadRequest,
      );
      expect(e1 == e3, false);
      final e4 = Exception();
      expect(e1 == e4, false);
    });
  });
  group('toString()', () {
    test('nullではないはず', () {
      expect(GitHubException.badRequest().toString(), isNotNull);
      expect(const GitHubException().toString(), isNotNull);
    });
  });
}
