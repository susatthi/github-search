// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/repositories/github/exception.dart';

void main() {
  group('コンストラクタ', () {
    test('生成出来るはず', () {
      expect(const GithubException(), isNotNull);
      expect(const GithubException('dummy'), isNotNull);
      expect(const GithubException('dummy', 'code'), isNotNull);
    });
  });
  group('factories', () {
    test('badRequestが生成出来るはず', () {
      final e = GithubException.badRequest();
      expect(e.code, 'bad-request');
    });
    test('badCredentialsが生成出来るはず', () {
      final e = GithubException.badCredentials();
      expect(e.code, 'bad-credentials');
    });
    test('maximumNumberOfLoginAttemptsExceededが生成出来るはず', () {
      final e = GithubException.maximumNumberOfLoginAttemptsExceeded();
      expect(e.code, 'maximum-number-of-login-attempts-exceeded');
    });
    test('notFoundが生成出来るはず', () {
      final e = GithubException.notFound();
      expect(e.code, 'not-found');
    });
    test('validationFailedが生成出来るはず', () {
      final e = GithubException.validationFailed();
      expect(e.code, 'validation-failed');
    });
    test('serviceUnavailableが生成出来るはず', () {
      final e = GithubException.serviceUnavailable();
      expect(e.code, 'service-unavailable');
    });
    test('unknownが生成出来るはず', () {
      final e = GithubException.unknown();
      expect(e.code, 'unknown');
    });
    test('noInternetConnectionが生成出来るはず', () {
      final e = GithubException.noInternetConnection();
      expect(e.code, 'no-internet-connection');
    });
  });
  group('operator ==', () {
    test('一致するはず', () {
      final e1 = GithubException.badRequest();
      final e2 = GithubException.badRequest();
      expect(e1 == e2, true);
    });
    test('一致しないはず', () {
      final e1 = GithubException.badRequest();
      final e2 = GithubException.badCredentials();
      expect(e1 == e2, false);

      const e3 = GithubException(
        'foo',
        GithubException.codeBadRequest,
      );
      expect(e1 == e3, false);
      final e4 = Exception();
      expect(e1 == e4, false);
    });
  });
  group('toString()', () {
    test('nullではないはず', () {
      expect(GithubException.badRequest().toString(), isNotNull);
      expect(const GithubException().toString(), isNotNull);
    });
  });
}
