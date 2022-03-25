// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/entities/owner/owner.dart';
import 'package:github_search/src/entities/owner/owner_data.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('コンストラクタ', () {
    test('インスタンスを作成できるはず', () async {
      const ownerData = OwnerData(name: 'dummy', avatarUrl: 'dummy');
      expect(ownerData, isNotNull);
    });
  });
  group('from()', () {
    test('インスタンスを作成できるはず', () async {
      final owner = Owner.fromJson(ownerJsonMap);
      final ownerData = OwnerData.from(owner);
      expect(ownerData, isNotNull);
    });
  });
}
