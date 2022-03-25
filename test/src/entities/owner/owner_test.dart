// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/owner/owner.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('コンストラクタ', () {
    test('インスタンスを作成できるはず', () async {
      const owner = Owner(login: 'dummy', avatarUrl: 'dummy');
      expect(owner, isNotNull);
    });
  });
  group('fromJson()', () {
    test('インスタンスを作成できるはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      expect(owner, isNotNull);
    });
  });
  group('toString()', () {
    test('正しく動くはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      expect(owner.toString(), isNotNull);
    });
  });
  group('toJson()', () {
    test('正しく動くはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      expect(owner.toJson(), isMap);
    });
  });
  group('copyWith()', () {
    test('一致するはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      final cloned = owner.copyWith();
      expect(owner.login == cloned.login, true);
      expect(owner.avatarUrl == cloned.avatarUrl, true);
    });
    test('一致しないはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      final cloned = owner.copyWith(
        login: 'dummy',
        avatarUrl: 'dummy',
      );
      expect(owner.login == cloned.login, false);
      expect(owner.avatarUrl == cloned.avatarUrl, false);
    });
  });
}