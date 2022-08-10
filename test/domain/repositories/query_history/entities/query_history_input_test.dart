// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repositories/query_history/entities/query_history_input.dart';

void main() {
  group('QueryHistoryInput', () {
    test('validate()が正しく動作するはず', () async {
      expect(
        () => QueryHistoryInput(queryString: '').validate(),
        throwsException,
      );
      expect(
        () => QueryHistoryInput(queryString: ' ').validate(),
        throwsException,
      );
      expect(
        () => QueryHistoryInput(queryString: '　').validate(),
        throwsException,
      );
      expect(
        () => QueryHistoryInput(queryString: ' 　 ').validate(),
        throwsException,
      );
    });
  });
}
