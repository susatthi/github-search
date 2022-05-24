// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/owner/owner.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/repositories/github/exception.dart';
import 'package:github_search/utils/extensions.dart';

import '../test_utils/locale.dart';

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
    useEnvironmentLocale();
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
  group('ObjectEx#toErrorMessage()', () {
    test('GitHubException.badRequestを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.badRequest().toErrorMessage(),
        i18n.gitHubExceptionMessage.badRequest,
      );
    });
    test('GitHubException.badCredentialsを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.badCredentials().toErrorMessage(),
        i18n.gitHubExceptionMessage.badCredentials,
      );
    });
    test(
        'GitHubException.maximumNumberOfLoginAttemptsExceededを与えてエラーメッセージが返るはず',
        () {
      expect(
        GitHubException.maximumNumberOfLoginAttemptsExceeded().toErrorMessage(),
        i18n.gitHubExceptionMessage.maximumNumberOfLoginAttemptsExceeded,
      );
    });
    test('GitHubException.notFoundを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.notFound().toErrorMessage(),
        i18n.gitHubExceptionMessage.notFound,
      );
    });
    test('GitHubException.validationFailedを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.validationFailed().toErrorMessage(),
        i18n.gitHubExceptionMessage.validationFailed,
      );
    });
    test('GitHubException.serviceUnavailableを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.serviceUnavailable().toErrorMessage(),
        i18n.gitHubExceptionMessage.serviceUnavailable,
      );
    });
    test('GitHubException.unknownを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.unknown().toErrorMessage(),
        i18n.gitHubExceptionMessage.unknown,
      );
    });
    test('GitHubException.noInternetConnectionを与えてエラーメッセージが返るはず', () {
      expect(
        GitHubException.noInternetConnection().toErrorMessage(),
        i18n.gitHubExceptionMessage.noInternetConnection,
      );
    });
    test('Exceptionを与えてエラーメッセージが返るはず', () {
      expect(
        Exception('dummy').toErrorMessage(),
        'Exception: dummy',
      );
    });
    test('Stringを与えてそのまま返るはず', () {
      const expectMessage = 'some message';
      expect(
        expectMessage.toErrorMessage(),
        expectMessage,
      );
    });
  });
}
