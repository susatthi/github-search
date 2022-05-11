// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/components/repo/repo_order_toggle_button.dart';
import 'package:github_search/presentation/components/repo/repo_search_text_field.dart';
import 'package:github_search/presentation/components/repo/repo_sort_selector_dialog.dart';
import 'package:github_search/presentation/pages/repo/repo_search_page.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/logger.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('RepoSearchPage', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoSearchPage(),
        ),
      );

      expect(find.byType(RepoSearchTextField), findsOneWidget);
      expect(find.byType(RepoOrderToggleButton), findsOneWidget);
      expect(find.byIcon(Icons.sort), findsOneWidget);

      // RepoSearchTextに自動でフォーカスが当たるはず
      final state = tester.firstState(find.byType(RepoSearchTextField))
          as RepoSearchTextFieldState;
      expect(state.focusNode.hasFocus, true);
    });
    testWidgets('ソートボタン押下で並び替えができるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoSearchPage(),
        ),
      );
      await tester.pumpAndSettle();

      // ソートアイコンをタップ
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pump();

      // ソート選択ダイアログが表示したはず
      await tester.pump();
      expect(find.byType(RepoSortSelectorDialog), findsOneWidget);

      // TODO(susatthi): 初期値はベストマッチであることを確認すること

      // stars をタップ
      await tester.runAsync<void>(() async {
        await tester.tap(find.text(i18n.starsCount));
      });
      await tester.pump();

      // ソート選択ダイアログが閉じたはず
      expect(find.byType(RepoSortSelectorDialog), findsNothing);

      // スター数に変更されたはず
      await tester.pump();
      // TODO(susatthi): スター数に変更されたことを確認すること
    });
    testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoSearchPage(),
        ),
      );
      await tester.pump();

      // 最初は降順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);

      // オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 1');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pump();

      // 昇順になったはず
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      await tester.pump();

      // もう一度オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 2');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pump();

      // 降順になったはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });
  });
}
