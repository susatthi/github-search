// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/presentation/pages/error/error_page.dart';
import 'package:github_search/src/presentation/pages/repo/repo_index_page.dart';
import 'package:go_router/go_router.dart';

import '../../mocks/mocks.dart';

void main() {
  testWidgets('存在しないパスに遷移するとエラー画面を表示するはず', (tester) async {
    await tester.pumpWidget(mockGithubSearchApp);
    await tester.pump();

    // 存在しないパスに遷移する
    tester
        .element(find.byWidgetPredicate((widget) => widget is RepoIndexPage))
        .go('/unknown');
    await tester.pumpAndSettle();

    // エラー画面が表示されるはず
    expect(find.byType(ErrorPage), findsOneWidget);
  });
}
