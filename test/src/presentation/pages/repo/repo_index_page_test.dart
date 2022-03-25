// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utils/mocks.dart';

void main() {
  testWidgets('画面が表示され必要なWidgetが存在し、戻るボタン押下で元の画面に戻れるはず', (tester) async {
    // リポジトリ一覧画面を表示したはず
    await tester.pumpWidget(mockApp);
    await tester.pump();
    expect(find.text('keyber-inc/github_search'), findsOneWidget);

    // ListTileをタップしてリポジトリ詳細画面に遷移する
    await tester.tap(find.byType(ListTile));
    await tester.pump();
    await tester.pump();

    // オーナー名
    expect(find.text('keyber-inc'), findsOneWidget);

    // リポジトリ名
    expect(find.text('github_search'), findsOneWidget);

    // プロジェクト言語
    expect(find.text('C++'), findsOneWidget);

    // プロジェクト言語
    expect(find.text('C++'), findsOneWidget);

    // AppBarの戻るボタン押下
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    await tester.pump();
    await tester.pump();

    // リポジトリ一覧画面を表示したはず
    expect(find.text('keyber-inc/github_search'), findsOneWidget);
  });
}
