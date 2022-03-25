// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/owner/owner_data.dart';
import 'package:github_search/src/entities/repo/repo.dart';
import 'package:github_search/src/entities/repo/repo_data.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('コンストラクタ', () {
    test('インスタンスを作成できるはず', () async {
      const repoData = RepoData(
        name: 'dummy',
        fullName: 'dummy',
        owner: OwnerData(name: 'dummy', avatarUrl: 'dummy'),
        stargazersCount: 1,
        watchersCount: 1,
        language: null,
        forksCount: 1,
        openIssuesCount: 1,
      );
      expect(repoData, isNotNull);
    });
  });
  group('from()', () {
    test('インスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(repoJsonMap);
      final repoData = RepoData.from(repo);
      expect(repoData, isNotNull);
    });
  });
}
