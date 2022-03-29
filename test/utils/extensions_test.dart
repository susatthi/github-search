// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/owner/owner.dart';
import 'package:github_search/utils/extensions.dart';

void main() {
  late List<int> listInt;
  late List<String> listString;
  late List<Owner> owners;
  setUp(() {
    listInt = [1, 2, 3, 4, 5, 4, 3, 7, 6, 3];
    listString = ['apple', 'banana', 'orange', '', 'banana', 'pine'];
    owners = const [
      Owner(login: 'user1', avatarUrl: 'url1'),
      Owner(login: 'user2', avatarUrl: 'url2'),
      Owner(login: 'user3', avatarUrl: 'url3'),
      Owner(login: 'user4', avatarUrl: 'url4'),
      Owner(login: 'user2', avatarUrl: 'url5'),
    ];
  });

  group('IterableEx#firstWhereOrNull()', () {
    test('List<int>型 検索がヒットして値を返すはず', () {
      expect(
        listInt.firstWhereOrNull((element) => element == 3),
        3,
      );
    });
    test('List<int>型 検索がヒットせずnullを返すはず', () {
      expect(
        listInt.firstWhereOrNull((element) => element == -1),
        null,
      );
    });
    test('List<String>型 検索がヒットして値を返すはず', () {
      expect(
        listString.firstWhereOrNull((element) => element == 'banana'),
        'banana',
      );
    });
    test('List<String>型 空文字でも検索がヒットして値を返すはず', () {
      expect(
        listString.firstWhereOrNull((element) => element == ''),
        '',
      );
    });
    test('List<String>型 検索がヒットせずnullを返すはず', () {
      expect(
        listString.firstWhereOrNull((element) => element == 'foo'),
        null,
      );
    });
    test('List<Object>型 検索がヒットして値を返すはず', () {
      expect(
        owners
            .firstWhereOrNull((element) => element.login == 'user2')
            ?.avatarUrl,
        'url2',
      );
    });
    test('List<Object>型 検索がヒットせずnullを返すはず', () {
      expect(
        owners.firstWhereOrNull((element) => element.login == 'foo')?.avatarUrl,
        null,
      );
    });
  });

  group('IterableEx#lastWhereOrNull()', () {
    test('List<int>型 検索がヒットして値を返すはず', () {
      expect(
        listInt.lastWhereOrNull((element) => element == 3),
        3,
      );
    });
    test('List<int>型 検索がヒットせずnullを返すはず', () {
      expect(
        listInt.lastWhereOrNull((element) => element == -1),
        null,
      );
    });
    test('List<String>型 検索がヒットして値を返すはず', () {
      expect(
        listString.lastWhereOrNull((element) => element == 'banana'),
        'banana',
      );
    });
    test('List<String>型 空文字でも検索がヒットして値を返すはず', () {
      expect(
        listString.lastWhereOrNull((element) => element == ''),
        '',
      );
    });
    test('List<String>型 検索がヒットせずnullを返すはず', () {
      expect(
        listString.lastWhereOrNull((element) => element == 'foo'),
        null,
      );
    });
    test('List<Object>型 検索がヒットして値を返すはず', () {
      expect(
        owners
            .lastWhereOrNull((element) => element.login == 'user2')
            ?.avatarUrl,
        'url5',
      );
    });
    test('List<Object>型 検索がヒットせずnullを返すはず', () {
      expect(
        owners.lastWhereOrNull((element) => element.login == 'foo')?.avatarUrl,
        null,
      );
    });
  });
}
