// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/repositories/github/exception.dart';

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
      expect(GithubException.badRequest(), isNotNull);
    });
    test('badCredentialsが生成出来るはず', () {
      expect(GithubException.badCredentials(), isNotNull);
    });
    test('maximumNumberOfLoginAttemptsExceededが生成出来るはず', () {
      expect(GithubException.maximumNumberOfLoginAttemptsExceeded(), isNotNull);
    });
    test('notFoundが生成出来るはず', () {
      expect(GithubException.notFound(), isNotNull);
    });
    test('validationFailedが生成出来るはず', () {
      expect(GithubException.validationFailed(), isNotNull);
    });
    test('serviceUnavailableが生成出来るはず', () {
      expect(GithubException.serviceUnavailable(), isNotNull);
    });
    test('unknownが生成出来るはず', () {
      expect(GithubException.unknown(), isNotNull);
    });
    test('noInternetConnectionが生成出来るはず', () {
      expect(GithubException.noInternetConnection(), isNotNull);
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
