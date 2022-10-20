// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/widgets/hyperlink_text.dart';

import '../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('HyperlinkText', () {
    testWidgets('正しく表示するはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: expectedText,
              url: 'https://keyber.jp',
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいるはず
      expect(find.byType(InkWell), findsOneWidget);
    });
    testWidgets('タップでURL起動ができるはず', (tester) async {
      const urlString = 'https://github.com';

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: 'リンク',
              url: urlString,
            ),
          ),
        ),
      );
      await tester.pump();

      // タップする
      await tester.tap(find.byType(HyperlinkText));
      await tester.pump();

      // URL起動出来ているはず
      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        true,
      );
    });
    testWidgets('不正なURLならSnackBarが表示されるはず', (tester) async {
      const urlString = 'https://999.168.0.1/';

      // URL起動失敗を返す
      agent.mockUrlLauncherPlatform.launchUrlReturnValue = false;

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: 'リンク',
              url: urlString,
            ),
          ),
        ),
      );
      await tester.pump();

      // SnackBarはいないはず
      expect(find.byType(SnackBar), findsNothing);

      // タップする
      await tester.tap(find.byType(HyperlinkText));
      await tester.pump();

      // URL起動を試みているはず
      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        true,
      );

      // SnackBarがいるはず
      expect(find.byType(SnackBar), findsOneWidget);
    });
    testWidgets('urlがnullならアンカー表示しないはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: expectedText,
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいないはず
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
