// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/hyperlink_text.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('HyperlinkText', () {
    testWidgets('正しく表示するはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: Scaffold(
            body: HyperlinkText(
              text: expectedText,
              onTap: () {},
            ),
          ),
        ),
      );

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいるはず
      expect(find.byType(InkWell), findsOneWidget);
    });
    testWidgets('タップイベントが検知できるはず', (tester) async {
      var isTapped = false;
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: Scaffold(
            body: HyperlinkText(
              text: 'リンク',
              onTap: () => isTapped = true,
            ),
          ),
        ),
      );

      // タップする
      await tester.tap(find.byType(HyperlinkText));
      await tester.pump();

      // タップイベントが検知できているはず
      expect(isTapped, true);
    });
    testWidgets('onTapがnullならアンカー表示しないはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: expectedText,
            ),
          ),
        ),
      );

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいないはず
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
