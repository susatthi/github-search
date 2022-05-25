// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/repo.dart';
import 'package:github_search/infrastructure/github/json_object/repo/repo.dart';
import 'package:github_search/infrastructure/github/repo_repository.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../test_utils/utils.dart';

void main() {
  final repo = GitHubRepoRepository.repoBuilder(
    RepoJsonObject.fromJson(
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
    ),
  );

  group('RepoHelper', () {
    test('stargazersCountShort', () async {
      expect(repo.stargazersCount, 137773);
      expect(repo.stargazersCountShort, '138k');
    });
    test('watchersCountShort', () async {
      expect(repo.watchersCount, 137773);
      expect(repo.watchersCountShort, '138k');
    });
    test('languageColor', () async {
      expect(repo.languageColor.value, HexColor('#00B4AB').value);
    });
    test('forksCountShort', () async {
      expect(repo.forksCount, 21221);
      expect(repo.forksCountShort, '21k');
    });
    test('openIssuesCountShort', () async {
      expect(repo.openIssuesCount, 10623);
      expect(repo.openIssuesCountShort, '11k');
    });
  });
}
