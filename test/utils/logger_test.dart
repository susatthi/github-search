// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/utils/logger.dart';

import '../test_utils/locale.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('logger', () {
    test('【String】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v('message');
      //ignore: cascade_invocations
      logger.d('message');
      //ignore: cascade_invocations
      logger.i('message');
      //ignore: cascade_invocations
      logger.w('message');
      //ignore: cascade_invocations
      logger.e('message');
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf('message');
        },
        throwsAssertionError,
      );
    });
    test('【String】ログが出力されるはず（エラーとStackTrace付き）', () async {
      //ignore: cascade_invocations
      logger.v('message', Exception('例外'), StackTrace.current);
      //ignore: cascade_invocations
      logger.d('message', Exception('例外'), StackTrace.current);
      //ignore: cascade_invocations
      logger.i('message', Exception('例外'), StackTrace.current);
      //ignore: cascade_invocations
      logger.w('message', Exception('例外'), StackTrace.current);
      //ignore: cascade_invocations
      logger.e('message', Exception('例外'), StackTrace.current);
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf('message', Exception('例外'), StackTrace.current);
        },
        throwsAssertionError,
      );
    });
    test('【int】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v(100);
      //ignore: cascade_invocations
      logger.d(100);
      //ignore: cascade_invocations
      logger.i(100);
      //ignore: cascade_invocations
      logger.w(100);
      //ignore: cascade_invocations
      logger.e(100);
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf(100);
        },
        throwsAssertionError,
      );
    });
    test('【double】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v(3.14);
      //ignore: cascade_invocations
      logger.d(3.14);
      //ignore: cascade_invocations
      logger.i(3.14);
      //ignore: cascade_invocations
      logger.w(3.14);
      //ignore: cascade_invocations
      logger.e(3.14);
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf(3.14);
        },
        throwsAssertionError,
      );
    });
    test('【bool】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v(true);
      //ignore: cascade_invocations
      logger.d(true);
      //ignore: cascade_invocations
      logger.i(true);
      //ignore: cascade_invocations
      logger.w(true);
      //ignore: cascade_invocations
      logger.e(true);
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf(true);
        },
        throwsAssertionError,
      );
    });
    test('【List<String>】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v(['apple', 'banana']);
      //ignore: cascade_invocations
      logger.d(['apple', 'banana']);
      //ignore: cascade_invocations
      logger.i(['apple', 'banana']);
      //ignore: cascade_invocations
      logger.w(['apple', 'banana']);
      //ignore: cascade_invocations
      logger.e(['apple', 'banana']);
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf(['apple', 'banana']);
        },
        throwsAssertionError,
      );
    });
    test('【Map<String, String>】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v({'key': 'name', 'value': 'apple'});
      //ignore: cascade_invocations
      logger.d({'key': 'name', 'value': 'apple'});
      //ignore: cascade_invocations
      logger.i({'key': 'name', 'value': 'apple'});
      //ignore: cascade_invocations
      logger.w({'key': 'name', 'value': 'apple'});
      //ignore: cascade_invocations
      logger.e({'key': 'name', 'value': 'apple'});
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf({'key': 'name', 'value': 'apple'});
        },
        throwsAssertionError,
      );
    });
    test('【dynamic Function()】ログが出力されるはず', () async {
      //ignore: cascade_invocations
      logger.v(() => '関数です');
      //ignore: cascade_invocations
      logger.d(() => '関数です');
      //ignore: cascade_invocations
      logger.i(() => '関数です');
      //ignore: cascade_invocations
      logger.w(() => '関数です');
      //ignore: cascade_invocations
      logger.e(() => '関数です');
      //ignore: cascade_invocations
      expect(
        () {
          logger.wtf(() => '関数です');
        },
        throwsAssertionError,
      );
    });
  });
}
