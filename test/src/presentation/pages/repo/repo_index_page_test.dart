// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/presentation/pages/repo/repo_view_page.dart';

import '../../../../mocks/mocks.dart';

void main() {
  testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
    await tester.pumpWidget(mockApp);

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
  testWidgets('テキスト検索を実行して検索結果が表示されるはず', (tester) async {
    await tester.pumpWidget(mockApp);
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
    await tester.pumpWidget(mockApp);
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
  testWidgets('リポジトリListTileをタップして詳細画面に遷移するはず', (tester) async {
    await tester.pumpWidget(mockApp);
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
