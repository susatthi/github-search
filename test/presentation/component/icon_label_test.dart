// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/component/icon_label.dart';

import '../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('IconLabel', () {
    testWidgets('引数無しで意図して動作するはず', (tester) async {
      const expectedIcon = Icons.search;
      const expectedText = 'アイコンラベル';
      await tester.pumpWidget(
        agent.mockApp(
          home: const IconLabel(
            icon: expectedIcon,
            text: expectedText,
          ),
        ),
      );
      await tester.pump();

      // アイコンが表示されるはず
      expect(find.byIcon(expectedIcon), findsOneWidget);

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);
    });
    testWidgets('タップイベントが検知できるはず', (tester) async {
      var isTapped = false;
      await tester.pumpWidget(
        agent.mockApp(
          home: Scaffold(
            body: IconLabel(
              icon: Icons.abc,
              text: 'アイコン',
              onTap: () => isTapped = true,
            ),
          ),
        ),
      );
      await tester.pump();

      // タップする
      await tester.tap(find.byType(IconLabel));
      await tester.pump();

      // タップイベントが検知できているはず
      expect(isTapped, true);
    });
  });
}
