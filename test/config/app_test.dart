// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/repo_index_page.dart';

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

  group('GitHubSearchApp', () {
    testWidgets('起動出来るはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();
      expect(find.byType(RepoIndexPage), findsOneWidget);
    });
  });
}
