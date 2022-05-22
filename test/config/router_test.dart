// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/common/error_page.dart';
import 'package:github_search/presentation/pages/repo/repo_index_page.dart';
import 'package:go_router/go_router.dart';

import '../test_utils/hive.dart';
import '../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('routerProvider', () {
    testWidgets('存在しないパスに遷移するとエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();

      expect(find.byType(RepoIndexPage), findsOneWidget);
      expect(find.byType(ErrorPage), findsNothing);

      // 存在しないパスに遷移する
      final state = tester.firstState(find.byType(RepoIndexPage));
      state.context.go('/unknown');
      await tester.pump();

      // エラー画面が表示されるはず
      await tester.pump();
      expect(find.byType(ErrorPage), findsOneWidget);
    });
  });
}
