// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/entities/repo.dart';
import 'package:github_search/presentation/repo/components/language_label.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('RepoLanguageLabel', () {
    testWidgets('正しく表示出来るはず', (tester) async {
      const expectedLanguage = RepoLanguage('Dart');

      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoLanguageLabel(
            language: expectedLanguage,
          ),
        ),
      );

      // アイコンが表示されるはず
      expect(find.byIcon(Icons.circle), findsOneWidget);

      // アイコンの色が指定した色になっているはず
      final icon = tester.widget(find.byIcon(Icons.circle)) as Icon;
      expect(icon.color, expectedLanguage.color);

      // プロジェクト言語が表示されるはず
      expect(find.text(expectedLanguage.language!), findsOneWidget);
    });
    testWidgets('プロジェクト言語がnullの場合は何も表示しないはず', (tester) async {
      const expectedLanguage = RepoLanguage();

      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoLanguageLabel(
            language: expectedLanguage,
          ),
        ),
      );

      // アイコンが表示されないはず
      expect(find.byIcon(Icons.circle), findsNothing);

      // プロジェクト言語が表示されないはず
      expect(find.byType(Text), findsNothing);
    });
  });
}
