// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/entities/repo/repo_data.dart';

import '../../../utils/assets.dart';

void main() {
  final repoJsonObject =
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!;
  group('from()', () {
    test('インスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(repoJsonObject);
      final repoData = RepoData.from(repo);
      expect(repoData, isNotNull);
    });
  });
}
