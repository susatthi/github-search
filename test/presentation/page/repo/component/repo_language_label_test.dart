// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/value/repo_language.dart';
import 'package:github_search/presentation/page/repo/component/repo_language_label.dart';

import '../../../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoLanguageLabel', () {
    testWidgets('正しく表示出来るはず', (tester) async {
      const expectedLanguage = RepoLanguage('Dart');

      await tester.pumpWidget(
        agent.mockApp(
          home: const RepoLanguageLabel(
            language: expectedLanguage,
          ),
        ),
      );
      await tester.pump();

      // アイコンが表示されるはず
      expect(find.byIcon(Icons.circle), findsOneWidget);

      // アイコンの色が指定した色になっているはず
      final icon = tester.widget(find.byIcon(Icons.circle)) as Icon;
      expect(icon.color, expectedLanguage.color);

      // プロジェクト言語が表示されるはず
      expect(find.text(expectedLanguage.display), findsOneWidget);
    });
    testWidgets('プロジェクト言語がnullの場合は何も表示しないはず', (tester) async {
      const expectedLanguage = RepoLanguage();

      await tester.pumpWidget(
        agent.mockApp(
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
