// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/owner/owner.dart';
import 'package:github_search/src/entities/repo/repo.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('コンストラクタ', () {
    test('インスタンスを作成できるはず', () async {
      const repo = Repo(
        name: 'dummy',
        fullName: 'dummy',
        owner: Owner(login: 'dummy', avatarUrl: 'dummy'),
        stargazersCount: 1,
        watchersCount: 1,
        forksCount: 1,
        openIssuesCount: 1,
      );
      expect(repo, isNotNull);
    });
  });
  group('fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      expect(repo, isNotNull);
    });
  });
  group('toString()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      expect(repo.toString(), isNotNull);
    });
  });
  group('toJson()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      expect(repo.toJson(), isMap);
    });
  });
  group('copyWith()', () {
    test('一致するはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      final cloned = repo.copyWith();
      expect(repo.name == cloned.name, true);
      expect(repo.fullName == cloned.fullName, true);
    });
    test('一致しないはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      final cloned = repo.copyWith(
        name: 'dummy',
        fullName: 'dummy',
      );
      expect(repo.name == cloned.name, false);
      expect(repo.fullName == cloned.fullName, false);
    });
  });
}
