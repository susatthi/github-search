// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/value_object/repo_count.dart';

void main() {
  group('RepoCountHelper', () {
    test('1桁の場合はそのまま表示するはず', () async {
      const count = RepoCount();
      expect(count.value, 0);
      expect(count.display, '0');
    });
    test('2桁の場合はそのまま表示するはず', () async {
      const count = RepoCount(12);
      expect(count.value, 12);
      expect(count.display, '12');
    });
    test('3桁の場合はそのまま表示するはず', () async {
      const count = RepoCount(342);
      expect(count.value, 342);
      expect(count.display, '342');
    });
    test('4桁の場合はそのまま表示するはず', () async {
      const count = RepoCount(8764);
      expect(count.value, 8764);
      expect(count.display, '8764');
    });
    test('5桁の場合はkで表示するはず', () async {
      const count = RepoCount(35432);
      expect(count.value, 35432);
      expect(count.display, '35k');
    });
    test('5桁で四捨五入するはず', () async {
      const count = RepoCount(35500);
      expect(count.value, 35500);
      expect(count.display, '36k');
    });
    test('6桁の場合はkで表示するはず', () async {
      const count = RepoCount(354327);
      expect(count.value, 354327);
      expect(count.display, '354k');
    });
    test('6桁で四捨五入するはず', () async {
      const count = RepoCount(355500);
      expect(count.value, 355500);
      expect(count.display, '356k');
    });
    test('7桁の場合はMで表示するはず', () async {
      const count = RepoCount(3543272);
      expect(count.value, 3543272);
      expect(count.display, '3.5M');
    });
    test('7桁で四捨五入するはず', () async {
      const count = RepoCount(3550000);
      expect(count.value, 3550000);
      expect(count.display, '3.6M');
    });
  });
}
