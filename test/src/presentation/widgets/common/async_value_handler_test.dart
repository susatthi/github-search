// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/gen/app_localizations_en.dart';
import 'package:github_search/src/localizations/l10n.dart';
import 'package:github_search/src/presentation/widgets/common/async_value_handler.dart';
import 'package:github_search/src/repositories/github/exception.dart';

class _TestApp<T> extends StatelessWidget {
  const _TestApp({
    Key? key,
    required this.asyncValue,
  }) : super(key: key);

  final AsyncValue<T> asyncValue;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: AsyncValueHandler<T>(
        value: asyncValue,
        builder: (value) => Text(value.toString()),
      ),
    );
  }
}

void main() {
  final l10n = AppLocalizationsEn();
  group('AsyncValueHandler', () {
    testWidgets('dataを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        const _TestApp<String>(asyncValue: AsyncValue.data('dummy')),
      );
      expect(find.text('dummy'), findsOneWidget);
    });
    testWidgets('loadingを与えて処理できるはず', (tester) async {
      await tester.pumpWidget(
        const _TestApp<String>(asyncValue: AsyncValue.loading()),
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
  await tester.pumpWidget(_TestApp<String>(asyncValue: AsyncValue.error(e)));
  expect(find.text(message), findsOneWidget);
}
