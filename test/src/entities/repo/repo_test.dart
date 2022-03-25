// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/repo/repo.dart';

import '../../../utils/assets.dart';

void main() {
  final repoJsonObject =
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!;
  final searchReposResultJsonObject =
      TestAssets.readJsonMap('github/search_repos_flutter_page1.json')!;
  group('Repo: fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      expect(repo, isNotNull);
    });
  });
  group('Repo: toString()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      expect(repo.toString(), isNotNull);
    });
  });
  group('Repo: toJson()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      expect(repo.toJson(), isMap);
    });
  });
  group('Repo: copyWith()', () {
    test('一致するはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      final cloned = repo.copyWith();
      expect(repo.name == cloned.name, true);
      expect(repo.fullName == cloned.fullName, true);
    });
    test('一致しないはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      final cloned = repo.copyWith(
        name: 'dummy',
        fullName: 'dummy',
      );
      expect(repo.name == cloned.name, false);
      expect(repo.fullName == cloned.fullName, false);
    });
  });
  group('SearchReposResult: fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final result = SearchReposResult.fromJson(searchReposResultJsonObject);
      expect(result, isNotNull);
    });
  });
  group('SearchReposResult: toString()', () {
    test('正しく動くはず', () async {
      final result = SearchReposResult.fromJson(searchReposResultJsonObject);
      expect(result.toString(), isNotNull);
    });
  });
  group('SearchReposResult: toJson()', () {
    test('正しく動くはず', () async {
      final result = SearchReposResult.fromJson(searchReposResultJsonObject);
      expect(result.toJson(), isMap);
    });
  });
  group('SearchReposResult: copyWith()', () {
    test('一致するはず', () async {
      final result = SearchReposResult.fromJson(searchReposResultJsonObject);
      final cloned = result.copyWith();
      expect(result.totalCount == cloned.totalCount, true);
    });
    test('一致しないはず', () async {
      final result = SearchReposResult.fromJson(searchReposResultJsonObject);
      final cloned = result.copyWith(
        totalCount: -1,
      );
      expect(result.totalCount == cloned.totalCount, false);
    });
  });
}
