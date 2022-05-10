// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/components/common/error_view.dart';
import 'package:github_search/repositories/github/exception.dart';

import '../../../test_utils/mocks.dart';

void main() {
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
    testWidgets('GitHubExceptionを与えてエラーメッセージが表示されるはず', (tester) async {
      await _wrapTest(
        tester,
        error: GitHubException.badRequest(),
        expectedMessage: i18n.gitHubExceptionMessage.badRequest,
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
  expect(find.text(expectedMessage), findsOneWidget);
}
