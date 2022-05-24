// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/pages/common/error_page.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('ErrorPage', () {
    testWidgets('errorがnullでも問題ないはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const ErrorPage(),
        ),
      );
      expect(find.text(i18n.errorOccurred), findsOneWidget);
    });
    testWidgets('errorがある場合でも問題ないはず', (tester) async {
      final error = Exception('dummy');
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: ErrorPage(
            error: error,
          ),
        ),
      );
      expect(find.text(error.toString()), findsOneWidget);
    });
  });
}
