// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/exceptions.dart';

import '../test_utils/locale.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('ValidatorException', () {
    test('引数無しで正しく動作するはず', () {
      const e = ValidatorException();
      expect(e.toString(), isNotNull);
      expect(e.errorMessages.length, 0);
      expect(e.errorMessage, '');
    });
    test('メッセージのみでも正しく動作するはず', () {
      const expectedMessage = 'dummy message';
      const e = ValidatorException(expectedMessage);
      expect(e.toString().contains(expectedMessage), true);
      expect(e.errorMessages.length, 0);
      expect(e.errorMessage, '');
    });
    test('メッセージとエラーメッセージでも正しく動作するはず', () {
      const expectedMessage = 'dummy message';
      const expetedErrorMessages = [
        'error message 1',
        'error message 2',
      ];
      const e = ValidatorException(expectedMessage, expetedErrorMessages);
      expect(e.toString().contains(expectedMessage), true);
      expect(e.toString().contains(expetedErrorMessages[0]), true);
      expect(e.toString().contains(expetedErrorMessages[1]), true);
      expect(e.errorMessages.isNotEmpty, true);
      expect(e.errorMessage, expetedErrorMessages.join('\n'));
    });
  });
  group('NetworkException', () {
    test('badRequestが生成出来るはず', () {
      final e = NetworkException.badRequest();
      expect(e.code, 'bad-request');
    });
    test('badCredentialsが生成出来るはず', () {
      final e = NetworkException.badCredentials();
      expect(e.code, 'bad-credentials');
    });
    test('maximumNumberOfLoginAttemptsExceededが生成出来るはず', () {
      final e = NetworkException.maximumNumberOfLoginAttemptsExceeded();
      expect(e.code, 'maximum-number-of-login-attempts-exceeded');
    });
    test('notFoundが生成出来るはず', () {
      final e = NetworkException.notFound();
      expect(e.code, 'not-found');
    });
    test('validationFailedが生成出来るはず', () {
      final e = NetworkException.validationFailed();
      expect(e.code, 'validation-failed');
    });
    test('serviceUnavailableが生成出来るはず', () {
      final e = NetworkException.serviceUnavailable();
      expect(e.code, 'service-unavailable');
    });
    test('unknownが生成出来るはず', () {
      final e = NetworkException.unknown();
      expect(e.code, 'unknown');
    });
    test('noInternetConnectionが生成出来るはず', () {
      final e = NetworkException.noInternetConnection();
      expect(e.code, 'no-internet-connection');
    });
  });
}
