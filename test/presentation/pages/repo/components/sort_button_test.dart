// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/pages/repo/components/sort_button.dart';
import 'package:github_search/presentation/pages/repo/components/sort_selector_bottom_sheet.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoSortButton', () {
    testWidgets('正しく表示できるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: RepoSortButton(),
          ),
        ),
      );
      await tester.pump();

      // tooltipが正しいはず
      final button = tester.widget(find.byType(IconButton)) as IconButton;
      expect(button.tooltip, i18n.sort);

      // アイコンが正しいはず
      final icon = button.icon as Icon;
      expect(icon.icon, Icons.sort);
    });

    testWidgets('ボタン押下でボトムシートを表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: RepoSortButton(),
          ),
        ),
      );
      await tester.pump();

      // まだ表示されていないはず
      expect(find.byType(RepoSortSelectorBottomSheet), findsNothing);

      // ボタンをタップ
      await tester.tap(find.byType(RepoSortButton));
      await tester.pumpAndSettle();

      // 表示したはず
      expect(find.byType(RepoSortSelectorBottomSheet), findsOneWidget);

      // 適当なところをタップ
      await tester.tapAt(const Offset(100, 100));
      await tester.pumpAndSettle();

      // 消えたはず
      expect(find.byType(RepoSortSelectorBottomSheet), findsNothing);
    });
  });
}
