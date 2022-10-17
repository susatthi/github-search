// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history.dart';

void main() {
  group('QueryHistory', () {
    test('validateが正しく動作するはず', () async {
      expect(
        () => QueryHistory.create(''),
        throwsException,
      );
      expect(
        () => QueryHistory.create(' '),
        throwsException,
      );
      expect(
        () => QueryHistory.create('　'),
        throwsException,
      );
      expect(
        () => QueryHistory.create(' 　 '),
        throwsException,
      );
      expect(
        () => QueryHistory.create(' 検索文字列'),
        throwsException,
      );
    });
  });
}
