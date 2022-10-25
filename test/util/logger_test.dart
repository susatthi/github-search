// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/util/logger.dart';

import '../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('logger', () {
    test('【String】ログが出力されるはず', () async {
      logger.v('message');
      logger.d('message');
      logger.i('message');
      logger.w('message');
      logger.e('message');
      expect(
        () {
          logger.wtf('message');
        },
        throwsAssertionError,
      );
    });
    test('【String】ログが出力されるはず（エラーとStackTrace付き）', () async {
      logger.v('message', Exception('例外'), StackTrace.current);
      logger.d('message', Exception('例外'), StackTrace.current);
      logger.i('message', Exception('例外'), StackTrace.current);
      logger.w('message', Exception('例外'), StackTrace.current);
      logger.e('message', Exception('例外'), StackTrace.current);
      expect(
        () {
          logger.wtf('message', Exception('例外'), StackTrace.current);
        },
        throwsAssertionError,
      );
    });
    test('【int】ログが出力されるはず', () async {
      logger.v(100);
      logger.d(100);
      logger.i(100);
      logger.w(100);
      logger.e(100);
      expect(
        () {
          logger.wtf(100);
        },
        throwsAssertionError,
      );
    });
    test('【double】ログが出力されるはず', () async {
      logger.v(3.14);
      logger.d(3.14);
      logger.i(3.14);
      logger.w(3.14);
      logger.e(3.14);
      expect(
        () {
          logger.wtf(3.14);
        },
        throwsAssertionError,
      );
    });
    test('【bool】ログが出力されるはず', () async {
      logger.v(true);
      logger.d(true);
      logger.i(true);
      logger.w(true);
      logger.e(true);
      expect(
        () {
          logger.wtf(true);
        },
        throwsAssertionError,
      );
    });
    test('【List<String>】ログが出力されるはず', () async {
      logger.v(['apple', 'banana']);
      logger.d(['apple', 'banana']);
      logger.i(['apple', 'banana']);
      logger.w(['apple', 'banana']);
      logger.e(['apple', 'banana']);
      expect(
        () {
          logger.wtf(['apple', 'banana']);
        },
        throwsAssertionError,
      );
    });
    test('【Map<String, String>】ログが出力されるはず', () async {
      logger.v({'key': 'name', 'value': 'apple'});
      logger.d({'key': 'name', 'value': 'apple'});
      logger.i({'key': 'name', 'value': 'apple'});
      logger.w({'key': 'name', 'value': 'apple'});
      logger.e({'key': 'name', 'value': 'apple'});
      expect(
        () {
          logger.wtf({'key': 'name', 'value': 'apple'});
        },
        throwsAssertionError,
      );
    });
    test('【dynamic Function()】ログが出力されるはず', () async {
      logger.v(() => '関数です');
      logger.d(() => '関数です');
      logger.i(() => '関数です');
      logger.w(() => '関数です');
      logger.e(() => '関数です');
      expect(
        () {
          logger.wtf(() => '関数です');
        },
        throwsAssertionError,
      );
    });
  });
  group('ProviderLogger', () {
    test('各種ログが出力されても問題ないはず', () {
      final container = ProviderContainer(
        observers: [
          ProviderLogger(),
        ],
      );

      final textProvider = StateProvider.autoDispose<String>(
        (ref) => 'hoge',
        name: 'textProvider',
      );
      container.read(textProvider);
      container.read(textProvider.notifier).state = 'foo';

      final errorProvider = Provider(
        (ref) => throw Exception(),
        name: 'errorProvider',
      );
      try {
        container.read(errorProvider);
      } on Exception catch (_) {
        // do nothing
      }
    });
  });
}
