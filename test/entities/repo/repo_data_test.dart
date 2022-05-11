// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/entities/repo/repo_data.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../test_utils/utils.dart';

void main() {
  late RepoData repoData;
  setUp(() {
    final repoJsonObject =
        TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!;
    final repo = Repo.fromJson(repoJsonObject);
    repoData = RepoData.from(repo);
  });

  group('RepoData', () {
    test('from()でインスタンスを作成できるはず', () async {
      expect(repoData, isNotNull);
    });
    test('stargazersCountShort', () async {
      expect(repoData.stargazersCount, 137773);
      expect(repoData.stargazersCountShort, '138k');
    });
    test('languageColor', () async {
      expect(repoData.languageColor.value, HexColor('#00B4AB').value);
    });
  });
}
