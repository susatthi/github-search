// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/exceptions.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/common/components/error_view.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/logger.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);

  group('ErrorView', () {
    testWidgets('Exceptionを与えてエラーメッセージが表示されるはず', (tester) async {
      await _wrapTest(
        tester,
        error: Exception('dummy'),
        expectedMessage: 'Exception: dummy',
      );
    });
    testWidgets('StackTraceを引数に与えることが出来るはず', (tester) async {
      await _wrapTest(
        tester,
        error: Exception('dummy'),
        stackTrace: StackTrace.current,
        expectedMessage: 'Exception: dummy',
      );
    });
    testWidgets('NetworkExceptionを与えてエラーメッセージが表示されるはず', (tester) async {
      await _wrapTest(
        tester,
        error: NetworkException.badRequest(),
        expectedMessage: i18n.networkExceptionMessage.badRequest,
      );
    });
    testWidgets('Stringを与えてStringが表示されるはず', (tester) async {
      const message = 'some message';
      await _wrapTest(
        tester,
        error: message,
        expectedMessage: message,
      );
    });
  });
  group('ObjectHelper.errorMessage', () {
    test('NetworkException.badRequestを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.badRequest().errorMessage,
        i18n.networkExceptionMessage.badRequest,
      );
    });
    test('NetworkException.badCredentialsを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.badCredentials().errorMessage,
        i18n.networkExceptionMessage.badCredentials,
      );
    });
    test(
        'NetworkException.maximumNumberOfLoginAttemptsExceeded'
        'を与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.maximumNumberOfLoginAttemptsExceeded().errorMessage,
        i18n.networkExceptionMessage.maximumNumberOfLoginAttemptsExceeded,
      );
    });
    test('NetworkException.notFoundを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.notFound().errorMessage,
        i18n.networkExceptionMessage.notFound,
      );
    });
    test('NetworkException.validationFailedを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.validationFailed().errorMessage,
        i18n.networkExceptionMessage.validationFailed,
      );
    });
    test('NetworkException.serviceUnavailableを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.serviceUnavailable().errorMessage,
        i18n.networkExceptionMessage.serviceUnavailable,
      );
    });
    test('NetworkException.unknownを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.unknown().errorMessage,
        i18n.networkExceptionMessage.unknown,
      );
    });
    test('NetworkException.noInternetConnectionを与えてエラーメッセージが返るはず', () {
      expect(
        NetworkException.noInternetConnection().errorMessage,
        i18n.networkExceptionMessage.noInternetConnection,
      );
    });
    test('Exceptionを与えてエラーメッセージが返るはず', () {
      expect(
        Exception('dummy').errorMessage,
        'Exception: dummy',
      );
    });
    test('Stringを与えてそのまま返るはず', () {
      const expectMessage = 'some message';
      expect(
        expectMessage.errorMessage,
        expectMessage,
      );
    });
  });
}

Future<void> _wrapTest(
  WidgetTester tester, {
  required Object error,
  StackTrace? stackTrace,
  required String expectedMessage,
}) async {
  await tester.pumpWidget(
    mockGitHubSearchApp(
      home: ErrorView(
        error: error,
        stackTrace: stackTrace,
      ),
    ),
  );
  testLogger.i(expectedMessage);
  expect(find.text(expectedMessage), findsOneWidget);
}
