// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/search_repos_order.dart';

void main() {
  group('SearchReposOrder', () {
    test('valueOf()でenum値が取れるはず', () async {
      expect(
        SearchReposOrder.nameOf(
          SearchReposOrder.asc.name,
        ),
        SearchReposOrder.asc,
      );
    });
    test('valueOf()でExceptionがthrowされるはず', () async {
      expect(
        () {
          SearchReposOrder.nameOf(
            'unknown value',
          );
        },
        throwsStateError,
      );
    });
  });
}
