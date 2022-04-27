// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/presentation/widgets/repo/repo_order_toggle_button.dart';
import 'package:github_search/repositories/github/api.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:github_search/repositories/github/repo_repository.dart';
import 'package:github_search/repositories/repo_repository.dart';

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

  group('RepoOrderToggleButton', () {
    testWidgets('ローディング中は無効化になるはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp);

      // ローディング中は無効化になるはず
      expect(find.byType(RepoOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<RepoOrderToggleButtonInternal>(
              find.byType(RepoOrderToggleButtonInternal),
            )
            .first
            .enabled,
        false,
      );

      await tester.pump();

      // ローディングが終了したら有効化になるはず
      expect(find.byType(RepoOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<RepoOrderToggleButtonInternal>(
              find.byType(RepoOrderToggleButtonInternal),
            )
            .first
            .enabled,
        true,
      );
    });
    testWidgets('エラー時は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repoRepositoryProvider.overrideWithValue(
              GitHubRepoRepository(
                api: const GitHubApi(),
                client: GitHubHttpClient(
                  token: 'dummy',
                  client: mockHttpClientError,
                ),
              ),
            ),
          ],
          child: const GitHubSearchApp(),
        ),
      );
      await tester.pump();

      // エラー時は無効化になるはず
      expect(find.byType(RepoOrderToggleButtonInternal), findsOneWidget);
      expect(
        tester
            .widgetList<RepoOrderToggleButtonInternal>(
              find.byType(RepoOrderToggleButtonInternal),
            )
            .first
            .enabled,
        false,
      );
    });
  });
}
