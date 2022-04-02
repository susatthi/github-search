// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/localizations/app_localizations_en.dart';
import 'package:github_search/presentation/widgets/common/async_value_handler.dart';
import 'package:github_search/repositories/github/exception.dart';

void main() {
  final l10n = AppLocalizationsEn();
  group('AsyncValueHandler', () {
    testWidgets('dataを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        GitHubSearchApp(
          home: const AsyncValueHandler<String>(
            value: AsyncValue.data('dummy'),
            builder: Text.new,
          ),
        ),
      );
      expect(find.text('dummy'), findsOneWidget);
    });
    testWidgets('loadingを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        GitHubSearchApp(
          home: const AsyncValueHandler<String>(
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
        l10n.gitHubExceptionMessageBadRequest,
      );
    });
    testWidgets('GitHubException.badCredentialsを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.badCredentials(),
        l10n.gitHubExceptionMessageBadCredentials,
      );
    });
    testWidgets(
        'GitHubException.maximumNumberOfLoginAttemptsExceededを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.maximumNumberOfLoginAttemptsExceeded(),
        l10n.gitHubExceptionMessageMaximumNumberOfLoginAttemptsExceeded,
      );
    });
    testWidgets('GitHubException.notFoundを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.notFound(),
        l10n.gitHubExceptionMessageNotFound,
      );
    });
    testWidgets('GitHubException.validationFailedを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.validationFailed(),
        l10n.gitHubExceptionMessageValidationFailed,
      );
    });
    testWidgets('GitHubException.serviceUnavailableを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.serviceUnavailable(),
        l10n.gitHubExceptionMessageServiceUnavailable,
      );
    });
    testWidgets('GitHubException.unknownを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GitHubException.unknown(),
        l10n.gitHubExceptionMessageUnknown,
      );
    });
    testWidgets('GitHubException.noInternetConnectionを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GitHubException.noInternetConnection(),
        l10n.gitHubExceptionMessageNoInternetConnection,
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
