// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utils/mocks.dart';

void main() {
  testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
    await tester.pumpWidget(mockApp);

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
  testWidgets('テキスト検索を実行して検索結果が表示されるはず', (tester) async {
    await tester.pumpWidget(mockApp);
    await tester.pump();

    expect(find.text('keyber-inc/github_search'), findsOneWidget);
    expect(find.text('keyber-inc/github_search2'), findsNothing);

    // 検索文字列を入力して検索ボタン押下
    await tester.enterText(find.byType(TextField), 'dummy');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    await tester.pump();
    expect(find.text('keyber-inc/github_search'), findsNothing);
    expect(find.text('keyber-inc/github_search2'), findsOneWidget);
  });
  testWidgets('キーボードのDone押下でもテキスト検索を実行するはず', (tester) async {
    await tester.pumpWidget(mockApp);
    await tester.pump();

    expect(find.text('keyber-inc/github_search'), findsOneWidget);
    expect(find.text('keyber-inc/github_search2'), findsNothing);

    // 検索文字列を入力してキーボードのDone押下
    await tester.enterText(find.byType(TextField), 'dummy');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.pump();
    expect(find.text('keyber-inc/github_search'), findsNothing);
    expect(find.text('keyber-inc/github_search2'), findsOneWidget);
  });
}
