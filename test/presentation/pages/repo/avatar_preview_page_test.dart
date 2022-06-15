// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/avatar_preview_page.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';

import '../../../test_utils/mocks.dart';
import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('AvatarPreviewPage', () {
    testWidgets('表示してタップで閉じるはず', (tester) async {
      await fakeSvg(() async {
        await tester.pumpWidget(agent.mockApp());
        await tester.pump();

        expect(find.text('flutter/plugins'), findsOneWidget);

        // リポジトリListTileをタップする
        await tester.tap(find.text('flutter/plugins'));
        await tester.pump();

        // 詳細画面に遷移したはず
        await tester.pump();
        expect(find.byType(RepoViewPage), findsOneWidget);

        // アバター画像をタップする
        await tester.tap(find.byKey(const Key('repo_detail_view#_AvatarRow')));
        await tester.pump();

        // アバタープレビュー画面に遷移するはず
        await tester.pump();
        expect(find.byType(AvatarPreviewPage), findsOneWidget);

        // 適当にタップする
        await tester.tap(find.byType(AvatarPreviewPage));
        await tester.pump();

        // アバタープレビュー画面が閉じるはず
        expect(find.byType(AvatarPreviewPage), findsNothing);
      });
    });
  });
}
