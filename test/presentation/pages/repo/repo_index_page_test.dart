// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/presentation/widgets/repo/repo_order_toggle_button.dart';
import 'package:github_search/presentation/widgets/repo/repo_sort_selector_dialog.dart';
import 'package:github_search/repositories/github/api.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:github_search/repositories/github/repo_repository.dart';
import 'package:github_search/repositories/hive/app_data_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';
import 'package:hive/hive.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../test_utils/logger.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Box<dynamic> appDataBox;
  setUp(() async {
    appDataBox = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox();
  });

  testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(RepoOrderToggleButton), findsOneWidget);
    expect(find.byIcon(Icons.sort), findsOneWidget);
  });
  testWidgets('エラーが発生したらエラー画面を表示するはず', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repoRepositoryProvider.overrideWithValue(
            GitHubRepoRepository(
              api: const GitHubApi(),
              client: GitHubHttpClient(
                token: 'dummy',
                client: mockHttpClientError,
              ),
            ),
          ),
          // モック版のHiveBoxを使う
          appDataBoxProvider.overrideWithValue(appDataBox),
        ],
        child: const GitHubSearchApp(),
      ),
    );
    await tester.pump();

    // エラー画面が表示されるはず
    expect(
      find.text(i18n.gitHubExceptionMessage.noInternetConnection),
      findsOneWidget,
    );

    // オーダートグルボタンは昇順のはず
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsNothing);

    // オーダートグルボタンが disable になっているので押せないはず
    await tester.tap(find.byType(RepoOrderToggleButton));
    await tester.pump();

    // エラー画面が表示されるはず
    expect(
      find.text(i18n.gitHubExceptionMessage.noInternetConnection),
      findsOneWidget,
    );

    // オーダートグルボタンは昇順のままのはず
    expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
  });
  testWidgets('テキスト検索を実行して検索結果が表示されるはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);
    expect(find.text('RN24Nishioka/ARmemo'), findsNothing);

    // 検索文字列を入力して検索ボタン押下
    await tester.enterText(find.byType(TextField), 'kboy');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    await tester.pump();
    expect(find.text('flutter/flutter'), findsNothing);
    expect(find.text('RN24Nishioka/ARmemo'), findsOneWidget);
  });
  testWidgets('キーボードのDone押下でもテキスト検索を実行するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);
    expect(find.text('RN24Nishioka/ARmemo'), findsNothing);

    // 検索文字列を入力してキーボードのDone押下
    await tester.enterText(find.byType(TextField), 'kboy');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.pump();
    expect(find.text('flutter/flutter'), findsNothing);
    expect(find.text('RN24Nishioka/ARmemo'), findsOneWidget);
  });
  testWidgets('一番下までスクロールしたら次のページを取得するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);
    expect(find.text('mahmudahsan/flutter'), findsNothing);

    // 一番下までスクロールする
    await _doScroll(tester, find.byType(ListView), const Offset(0, 2000));
    expect(find.text('mahmudahsan/flutter'), findsOneWidget);
  });
  testWidgets('リポジトリListTileをタップして詳細画面に遷移するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);

    // 検索文字列を入力してキーボードのDone押下
    await tester.tap(find.text('flutter/flutter'));
    await tester.pump();

    // 詳細画面に遷移したはず
    await tester.pump();
    expect(find.byType(RepoViewPage), findsOneWidget);
  });
  testWidgets('ソートボタン押下で並び替えができるはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);
    expect(find.text('flutter/plugins'), findsOneWidget);
    expect(find.text('iampawan/FlutterExampleApps'), findsOneWidget);
    expect(find.text('Solido/awesome-flutter'), findsOneWidget);
    expect(find.text('kaina404/FlutterDouBan'), findsOneWidget);
    expect(find.text('samarthagarwal/FlutterScreens'), findsOneWidget);
    expect(find.text('firebase/flutterfire'), findsOneWidget);
    expect(find.text('alibaba/flutter-go'), findsOneWidget);

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
    expect(find.text('mitesh77/Best-Flutter-UI-Templates'), findsOneWidget);
    expect(find.text('Tencent/MMKV'), findsOneWidget);
  });

  testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp(appDataBox));
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
}

/// Scrolls the specified widget by the specified offset and waits sufficiently
/// long for the [VisibilityDetector] callbacks to fire.
///
/// see: https://github.com/google/flutter.widgets/blob/master/packages/visibility_detector/test/widget_test.dart
Future<void> _doScroll(
  WidgetTester tester,
  Finder finder,
  Offset scrollOffset,
) async {
  // The scroll direction is the opposite of the direction to drag.  We also
  // must drag by [kDragSlopDefault] first to start the drag.
  final dragOffset = -Offset.fromDirection(
    scrollOffset.direction,
    scrollOffset.distance + kDragSlopDefault,
  );
  await tester.drag(finder, dragOffset);

  // Wait for the drag to complete.
  await tester.pumpAndSettle();

  // Wait for callbacks to fire.
  await tester.pump(VisibilityDetectorController.instance.updateInterval);
}
