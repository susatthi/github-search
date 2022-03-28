// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/gen/app_localizations_en.dart';
import 'package:github_search/src/config/github_search_app.dart';
import 'package:github_search/src/presentation/pages/error/error_page.dart';

void main() {
  final l10n = AppLocalizationsEn();
  testWidgets('errorがnullでも問題ないはず', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: GithubSearchApp(
          home: const ErrorPage(),
        ),
      ),
    );
    expect(find.text(l10n.errorOccurred), findsOneWidget);
  });
  testWidgets('errorがある場合でも問題ないはず', (tester) async {
    final error = Exception('dummy');
    await tester.pumpWidget(
      ProviderScope(
        child: GithubSearchApp(
          home: ErrorPage(
            error: error,
          ),
        ),
      ),
    );
    expect(find.text(error.toString()), findsOneWidget);
  });
}
