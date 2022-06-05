// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/json_objects/owner.dart';
import 'package:github_search/utils/extensions.dart';

import '../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  late List<int> listInt;
  late List<String> listString;
  late List<OwnerJsonObject> owners;
  setUp(() async {
    await agent.setUp();
    listInt = [1, 2, 3, 4, 5, 4, 3, 7, 6, 3];
    listString = ['apple', 'banana', 'orange', '', 'banana', 'pine'];
    owners = const [
      OwnerJsonObject(login: 'user1', avatarUrl: 'url1'),
      OwnerJsonObject(login: 'user2', avatarUrl: 'url2'),
      OwnerJsonObject(login: 'user3', avatarUrl: 'url3'),
      OwnerJsonObject(login: 'user4', avatarUrl: 'url4'),
      OwnerJsonObject(login: 'user2', avatarUrl: 'url5'),
    ];
  });
  tearDown(agent.tearDown);

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
