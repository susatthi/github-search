// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../test_utils/hive.dart';

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('GitHubSearchApp', () {
    // testWidgets('存在しないパスに遷移するとエラー画面を表示するはず', (tester) async {
    //   await tester.pumpWidget(mockGitHubSearchApp());
    //   await tester.pump();
    //
    //   // 存在しないパスに遷移する
    //   tester
    //       .element(
    //         find.byWidgetPredicate((widget) => widget is RepoIndexPage),
    //       )
    //       .go('/unknown');
    //   await tester.pumpAndSettle();
    //
    //   // エラー画面が表示されるはず
    //   expect(find.byType(ErrorPage), findsOneWidget);
    // });
  });
}
