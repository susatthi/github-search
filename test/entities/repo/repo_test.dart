// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';

import '../../test_utils/utils.dart';

void main() {
  final jsonMap =
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!;
  group('fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo, isNotNull);
    });
  });
  group('toString()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo.toString(), isNotNull);
    });
  });
  group('toJson()', () {
    test('正しく動くはず', () async {
      final repo = Repo.fromJson(jsonMap);
      expect(repo.toJson(), isMap);
    });
  });
  group('copyWith()', () {
    test('一致するはず', () async {
      final repo = Repo.fromJson(jsonMap);
      final cloned = repo.copyWith();
      expect(repo.name == cloned.name, true);
      expect(repo.fullName == cloned.fullName, true);
    });
    test('一致しないはず', () async {
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
