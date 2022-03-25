// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/utils/logger.dart';

void main() {
  group('logger', () {
    test('各種ログが出力されるはず', () async {
      expect(logger.finest('message')?.contains('message'), true);
      expect(logger.finer('message')?.contains('message'), true);
      expect(logger.fine('message')?.contains('message'), true);
      expect(logger.config('message')?.contains('message'), true);
      expect(logger.info('message')?.contains('message'), true);
      expect(logger.warning('message')?.contains('message'), true);
    });
    test('致命的エラーのログはassertが発生するはず', () async {
      expect(
        () {
          logger.severe('message');
        },
        throwsAssertionError,
      );
      expect(
        () {
          logger.shout('message');
        },
        throwsAssertionError,
      );
    });
    test('いろんな型を与えてもログが出力されるはず', () async {
      expect(logger.info(1)?.contains('1'), true);
      expect(logger.info(Exception())?.contains('Exception'), true);
      expect(logger.info(<String>['dummy'])?.contains('[dummy]'), true);
      expect(logger.info(<int>[1, 2, 3])?.contains('[1, 2, 3]'), true);
      expect(
        logger.info(<String, dynamic>{'dummy': 'dummy'})?.contains(
          '{dummy: dummy}',
        ),
        true,
      );
    });
  });
}
