// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/exceptions.dart';

import '../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('ValidatorException', () {
    test('invalidArgumentが生成出来るはず', () {
      final e = ValidatorException.invalidArgument();
      expect(e.code, 'invalid-argument');
      expect(e.message, 'Invalid argument');
      expect(e.target, isNull);
    });
    test('invalidArgument（targetあり）が生成出来るはず', () {
      final e = ValidatorException.invalidArgument('someTarget');
      expect(e.code, 'invalid-argument');
      expect(e.message, 'Invalid argument');
      expect(e.target, 'someTarget');
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
