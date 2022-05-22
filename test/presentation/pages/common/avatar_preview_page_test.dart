// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/cached_circle_avatar.dart';
import 'package:github_search/presentation/pages/common/avatar_preview_page.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('AvatarPreviewPage', () {
    testWidgets('表示してタップで閉じるはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pump();

      expect(find.text('flutter/flutter'), findsOneWidget);

      // リポジトリListTileをタップする
      await tester.tap(find.text('flutter/flutter'));
      await tester.pump();

      // 詳細画面に遷移したはず
      await tester.pump();
      expect(find.byType(RepoViewPage), findsOneWidget);

      // アバター画像をタップする
      await tester.tap(find.byType(CachedCircleAvatar).last);
      await tester.pump();

      // アバタープレビュー画面に遷移するはず
      await tester.pump();
      expect(find.byType(AvatarPreviewPage), findsOneWidget);

      // タップする
      await tester.tap(find.byType(AvatarPreviewPage));
      await tester.pump();

      // アバタープレビュー画面が閉じるはず
      expect(find.byType(AvatarPreviewPage), findsNothing);
    });
  });
}
