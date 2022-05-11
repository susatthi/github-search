// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/components/repo/repo_order_toggle_button.dart';
import 'package:github_search/presentation/components/repo/repo_search_text_button.dart';
import 'package:github_search/presentation/components/repo/repo_search_text_field.dart';
import 'package:github_search/presentation/components/repo/repo_sort_selector_dialog.dart';
import 'package:github_search/presentation/pages/repo/repo_index_page.dart';
import 'package:github_search/presentation/pages/repo/repo_search_page.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/repositories/github/http_client.dart';

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

  group('RepoIndexPage', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoIndexPage(),
        ),
      );

      expect(find.byType(RepoSearchTextButton), findsOneWidget);
      expect(find.byType(RepoOrderToggleButton), findsOneWidget);
      expect(find.byIcon(Icons.sort), findsOneWidget);
    });
    testWidgets('エラーが発生したらエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: const RepoIndexPage(),
        ),
      );
      await tester.pump();

      // エラー画面が表示されるはず
      expect(
        find.text(i18n.gitHubExceptionMessage.noInternetConnection),
        findsOneWidget,
      );

      // オーダー変更ボタンは昇順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsNothing);

      // オーダー変更ボタンが disable になっているので押せないはず
      await tester.tap(find.byType(RepoOrderToggleButton));

      // エラー画面が表示されるはず
      expect(
        find.text(i18n.gitHubExceptionMessage.noInternetConnection),
        findsOneWidget,
      );

      // オーダー変更ボタンは昇順のままのはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.arrow_upward), findsNothing);
    });
    testWidgets('テキスト検索を実行して検索結果が表示されるはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();

      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('RN24Nishioka/ARmemo'), findsNothing);

      // 検索ボタン押下で検索ページに遷移する
      await tester.tap(find.byType(RepoSearchTextButton));
      await tester.pumpAndSettle();

      // 検索画面に遷移したはず
      expect(find.byType(RepoSearchPage), findsOneWidget);

      // 検索文字列を入力して検索ボタン押下
      await tester.enterText(find.byType(RepoSearchTextField).last, 'kboy');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // 一覧画面に戻ってきて検索結果が変わっているはず
      expect(find.text('flutter/flutter'), findsNothing);
      expect(find.text('RN24Nishioka/ARmemo'), findsOneWidget);
    });
    testWidgets('リポジトリListTileをタップして詳細画面に遷移するはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();

      expect(find.text('flutter/flutter'), findsOneWidget);

      // リポジトリListTileをタップする
      await tester.tap(find.text('flutter/flutter'));
      await tester.pump();

      // 詳細画面に遷移したはず
      await tester.pump();
      expect(find.byType(RepoViewPage), findsOneWidget);
    });
    testWidgets('ソートボタン押下で並び替えができるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoIndexPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('flutter/plugins'), findsOneWidget);
      expect(find.text('iampawan/FlutterExampleApps'), findsOneWidget);
      expect(find.text('Solido/awesome-flutter'), findsOneWidget);
      expect(find.text('kaina404/FlutterDouBan'), findsOneWidget);
      expect(find.text('samarthagarwal/FlutterScreens'), findsOneWidget);

      // ソートアイコンをタップ
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pump();

      // ソート選択ダイアログが表示したはず
      await tester.pump();
      expect(find.byType(RepoSortSelectorDialog), findsOneWidget);

      // stars をタップ
      await tester.runAsync<void>(() async {
        await tester.tap(find.text(i18n.starsCount));
      });
      await tester.pump();

      // ソート選択ダイアログが閉じたはず
      expect(find.byType(RepoSortSelectorDialog), findsNothing);

      // スター数に変更されたはず
      await tester.pump();
      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('Solido/awesome-flutter'), findsOneWidget);
      expect(find.text('alibaba/flutter-go'), findsOneWidget);
      expect(find.text('appwrite/appwrite'), findsOneWidget);
      expect(find.text('AppFlowy-IO/AppFlowy'), findsOneWidget);
      expect(find.text('iampawan/FlutterExampleApps'), findsOneWidget);
    });
    testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const RepoIndexPage(),
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
  group('AnimatedAppBarBackground', () {
    testWidgets('リポジトリ一覧画面からの画面遷移時にアニメーションするはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();

      final state = tester.firstState(find.byType(AnimatedAppBarBackground))
          as AnimatedAppBarBackgroundState;

      // 最初は折り畳んでいる状態のはず
      expect(state.isFilled, false);

      // 検索ボタン押下で検索ページに遷移する
      await tester.tap(find.byType(RepoSearchTextButton));
      await tester.pumpAndSettle();

      // 検索画面に遷移した後は広がっているはず
      expect(state.isFilled, true);

      // 検索文字列を入力して検索ボタン押下
      await tester.enterText(find.byType(RepoSearchTextField).last, 'kboy');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // 一覧画面に戻ってきて折り畳んでいる状態のはず
      expect(state.isFilled, false);
    });
  });
}
