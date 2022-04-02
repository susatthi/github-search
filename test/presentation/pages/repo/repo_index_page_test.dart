// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../test_utils/mocks.dart';

void main() {
  testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp);

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
  testWidgets('テキスト検索を実行して検索結果が表示されるはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp);
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
    await tester.pumpWidget(mockGitHubSearchApp);
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
    await tester.pumpWidget(mockGitHubSearchApp);
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);
    expect(find.text('mahmudahsan/flutter'), findsNothing);

    // 一番下までスクロールする
    await _doScroll(tester, find.byType(ListView), const Offset(0, 2000));
    expect(find.text('mahmudahsan/flutter'), findsOneWidget);
  });
  testWidgets('リポジトリListTileをタップして詳細画面に遷移するはず', (tester) async {
    await tester.pumpWidget(mockGitHubSearchApp);
    await tester.pump();

    expect(find.text('flutter/flutter'), findsOneWidget);

    // 検索文字列を入力してキーボードのDone押下
    await tester.tap(find.text('flutter/flutter'));
    await tester.pump();

    // 詳細画面に遷移したはず
    await tester.pump();
    expect(find.byType(RepoViewPage), findsOneWidget);
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
