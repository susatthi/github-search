// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/search_repos_result/search_repos_result.dart';

import '../../../utils/assets.dart';

void main() {
  final jsonMap =
      TestAssets.readJsonMap('github/search_repos_flutter_page1.json')!;
  group('fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final result = SearchReposResult.fromJson(jsonMap);
      expect(result, isNotNull);
    });
  });
  group('toString()', () {
    test('正しく動くはず', () async {
      final result = SearchReposResult.fromJson(jsonMap);
      expect(result.toString(), isNotNull);
    });
  });
  group('toJson()', () {
    test('正しく動くはず', () async {
      final result = SearchReposResult.fromJson(jsonMap);
      expect(result.toJson(), isMap);
    });
  });
  group('copyWith()', () {
    test('一致するはず', () async {
      final result = SearchReposResult.fromJson(jsonMap);
      final cloned = result.copyWith();
      expect(result.totalCount == cloned.totalCount, true);
    });
    test('一致しないはず', () async {
      final result = SearchReposResult.fromJson(jsonMap);
      final cloned = result.copyWith(
        totalCount: -1,
      );
      expect(result.totalCount == cloned.totalCount, false);
    });
  });
}
