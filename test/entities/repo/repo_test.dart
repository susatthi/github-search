// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';

import '../../test_utils/utils.dart';

void main() {
  final jsonMap =
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!;
  group('Repo', () {
    test('fromJson()でインスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo, isNotNull);
    });
    test('toString()', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo.toString(), isNotNull);
    });
    test('toJson()', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo.toJson(), isMap);
    });
    test('copyWith()一致するはず', () async {
      final repo = Repo.fromJson(jsonMap);
      final cloned = repo.copyWith();
      expect(repo.name == cloned.name, true);
      expect(repo.fullName == cloned.fullName, true);
    });
    test('copyWith()一致しないはず', () async {
      final repo = Repo.fromJson(jsonMap);
      final cloned = repo.copyWith(
        name: 'dummy',
        fullName: 'dummy',
      );
      expect(repo.name == cloned.name, false);
      expect(repo.fullName == cloned.fullName, false);
    });
  });
}
