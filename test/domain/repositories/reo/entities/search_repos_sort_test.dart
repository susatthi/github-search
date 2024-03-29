// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/search_repos_sort.dart';

void main() {
  group('SearchReposSort', () {
    test('valueOf()でenum値が取れるはず', () async {
      expect(
        SearchReposSort.nameOf(
          SearchReposSort.bestMatch.name,
        ),
        SearchReposSort.bestMatch,
      );
    });
    test('valueOf()でExceptionがthrowされるはず', () async {
      expect(
        () {
          SearchReposSort.nameOf(
            'unknown value',
          );
        },
        throwsStateError,
      );
    });
  });
}
