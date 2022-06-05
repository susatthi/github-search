// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/json_objects/search_repos_result.dart';

import '../../../test_utils/utils.dart';

void main() {
  final jsonMap =
      TestAssets.readJsonMap('github/search_repos_flutter_page1.json')!;
  group('SearchReposResultJsonObject', () {
    test('fromJson()でインスタンスを作成できるはず', () async {
      final result = SearchReposResultJsonObject.fromJson(jsonMap);
      expect(result, isNotNull);
    });
    test('toString()', () async {
      final result = SearchReposResultJsonObject.fromJson(jsonMap);
      expect(result.toString(), isNotNull);
    });
    test('toJson()', () async {
      final result = SearchReposResultJsonObject.fromJson(jsonMap);
      expect(result.toJson(), isMap);
    });
    test('copyWith()一致するはず', () async {
      final result = SearchReposResultJsonObject.fromJson(jsonMap);
      final cloned = result.copyWith();
      expect(result.totalCount == cloned.totalCount, true);
    });
    test('copyWith()一致しないはず', () async {
      final result = SearchReposResultJsonObject.fromJson(jsonMap);
      final cloned = result.copyWith(
        totalCount: -1,
      );
      expect(result.totalCount == cloned.totalCount, false);
    });
  });
}
