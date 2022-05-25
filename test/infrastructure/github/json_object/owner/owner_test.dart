// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/json_object/owner/owner.dart';

import '../../../../test_utils/utils.dart';

void main() {
  final ownerJsonObject = TestAssets.readJsonMap('github/owner.json')!;
  group('OwnerJsonObject', () {
    test('fromJson()でインスタンスを作成できるはず', () async {
      final owner = OwnerJsonObject.fromJson(ownerJsonObject);
      expect(owner, isNotNull);
    });
    test('toString()', () async {
      final owner = OwnerJsonObject.fromJson(ownerJsonObject);
      expect(owner.toString(), isNotNull);
    });
    test('toJson()', () async {
      final owner = OwnerJsonObject.fromJson(ownerJsonObject);
      expect(owner.toJson(), isMap);
    });
    test('copyWith()一致するはず', () async {
      final owner = OwnerJsonObject.fromJson(ownerJsonObject);
      final cloned = owner.copyWith();
      expect(owner.login == cloned.login, true);
      expect(owner.avatarUrl == cloned.avatarUrl, true);
    });
    test('copyWith()一致しないはず', () async {
      final owner = OwnerJsonObject.fromJson(ownerJsonObject);
      final cloned = owner.copyWith(
        login: 'dummy',
        avatarUrl: 'dummy',
      );
      expect(owner.login == cloned.login, false);
      expect(owner.avatarUrl == cloned.avatarUrl, false);
    });
  });
}
