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

  group('ValueObject', () {
    test('RepoLanguage(value != null)', () async {
      expect(repo.language.value, 'Dart');
      expect(repo.language.display, 'Dart');
      expect(repo.language.color.value, HexColor('#00B4AB').value);
    });
    test('RepoLanguage(value = null)', () async {
      const language = RepoLanguage();
      expect(language.value, isNull);
      expect(language.display, '');
      expect(language.color.value, HexColor('#999999').value);
    });
    test('StargazersCount', () async {
      expect(repo.stargazersCount, 137773);
      expect(repo.stargazersCount.display, '138k');
    });
    test('watchersCount', () async {
      expect(repo.watchersCount, 137773);
      expect(repo.watchersCount.display, '138k');
    });
    test('forksCount', () async {
      expect(repo.forksCount, 21221);
      expect(repo.forksCount.display, '21k');
    });
    test('openIssuesCount', () async {
      expect(repo.openIssuesCount, 10623);
      expect(repo.openIssuesCount.display, '11k');
    });
  });
}
