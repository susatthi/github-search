// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/widgets/common/async_value_handler.dart';
import 'package:github_search/repositories/github/exception.dart';

void main() {
  group('AsyncValueHandler', () {
    testWidgets('dataを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        const GitHubSearchApp(
          home: AsyncValueHandler<String>(
            value: AsyncValue.data('dummy'),
            builder: Text.new,
          ),
        ),
      );
      expect(find.text('dummy'), findsOneWidget);
    });
    testWidgets('loadingを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        const GitHubSearchApp(
          home: AsyncValueHandler<String>(
            value: AsyncValue.loading(),
            builder: Text.new,
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('GitHubException.badRequestを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.badRequest(),
        i18n.gitHubExceptionMessage.badRequest,
      );
    });
    testWidgets('GitHubException.badCredentialsを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.badCredentials(),
        i18n.gitHubExceptionMessage.badCredentials,
      );
    });
    testWidgets(
        'GitHubException.maximumNumberOfLoginAttemptsExceededを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.maximumNumberOfLoginAttemptsExceeded(),
        i18n.gitHubExceptionMessage.maximumNumberOfLoginAttemptsExceeded,
      );
    });
    testWidgets('GitHubException.notFoundを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.notFound(),
        i18n.gitHubExceptionMessage.notFound,
      );
    });
    testWidgets('GitHubException.validationFailedを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.validationFailed(),
        i18n.gitHubExceptionMessage.validationFailed,
      );
    });
    testWidgets('GitHubException.serviceUnavailableを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.serviceUnavailable(),
        i18n.gitHubExceptionMessage.serviceUnavailable,
      );
    });
    testWidgets('GitHubException.unknownを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.unknown(),
        i18n.gitHubExceptionMessage.unknown,
      );
    });
    testWidgets('GitHubException.noInternetConnectionを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.noInternetConnection(),
        i18n.gitHubExceptionMessage.noInternetConnection,
      );
    });
    testWidgets('Exceptionを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        Exception('dummy'),
        'Exception: dummy',
      );
    });
  });
}

Future<void> _wrapTest(
  WidgetTester tester,
  Exception e,
  String message,
) async {
  await tester.pumpWidget(
    GitHubSearchApp(
      home: AsyncValueHandler<Exception>(
        value: AsyncValue.error(e),
        builder: (value) => Text(value.toString()),
      ),
    ),
  );
  expect(find.text(message), findsOneWidget);
}
