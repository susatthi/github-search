// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/pages/avatar_preview_page.dart';
import 'package:github_search/presentation/repo/pages/view_page.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
    useEnvironmentLocale();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('RepoAvatarPreviewPage', () {
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
      await tester.tap(find.byKey(const Key('repo_detail_view#_AvatarRow')));
      await tester.pump();

      // アバタープレビュー画面に遷移するはず
      await tester.pump();
      expect(find.byType(RepoAvatarPreviewPage), findsOneWidget);

      // 適当にタップする
      await tester.tap(find.byType(RepoAvatarPreviewPage));
      await tester.pump();

      // アバタープレビュー画面が閉じるはず
      expect(find.byType(RepoAvatarPreviewPage), findsNothing);
    });
  });
}
