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
        GithubSearchApp(
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
        GithubSearchApp(
          home: const AsyncValueHandler<String>(
            value: AsyncValue.loading(),
            builder: Text.new,
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('GithubException.badRequestを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GithubException.badRequest(),
        l10n.githubApiExceptionMessageBadRequest,
      );
    });
    testWidgets('GithubException.badCredentialsを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GithubException.badCredentials(),
        l10n.githubApiExceptionMessageBadCredentials,
      );
    });
    testWidgets(
        'GithubException.maximumNumberOfLoginAttemptsExceededを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GithubException.maximumNumberOfLoginAttemptsExceeded(),
        l10n.githubApiExceptionMessageMaximumNumberOfLoginAttemptsExceeded,
      );
    });
    testWidgets('GithubException.notFoundを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GithubException.notFound(),
        l10n.githubApiExceptionMessageNotFound,
      );
    });
    testWidgets('GithubException.validationFailedを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GithubException.validationFailed(),
        l10n.githubApiExceptionMessageValidationFailed,
      );
    });
    testWidgets('GithubException.serviceUnavailableを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GithubException.serviceUnavailable(),
        l10n.githubApiExceptionMessageServiceUnavailable,
      );
    });
    testWidgets('GithubException.unknownを与えて処理できるはず', (tester) async {
      await _wrapTest(
        tester,
        GithubException.unknown(),
        l10n.githubApiExceptionMessageUnknown,
      );
    });
    testWidgets('GithubException.noInternetConnectionを与えて処理できるはず',
        (tester) async {
      await _wrapTest(
        tester,
        GithubException.noInternetConnection(),
        l10n.githubApiExceptionMessageNoInternetConnection,
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
    GithubSearchApp(
      home: AsyncValueHandler<Exception>(
        value: AsyncValue.error(e),
        builder: (value) => Text(value.toString()),
      ),
    ),
  );
  expect(find.text(message), findsOneWidget);
}
