// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/repo/components/repo_order_toggle_button.dart';
import 'package:github_search/presentation/repo/components/repo_search_repos_query.dart';

import '../../../test_utils/hive.dart';
import '../../../test_utils/locale.dart';
import '../../../test_utils/logger.dart';
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

  group('RepoOrderToggleButton', () {
    testWidgets('オーダーボタン押下で昇順降順を切り替えられるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: RepoOrderToggleButton(),
          ),
        ),
      );
      await tester.pump();

      // 最初は降順のはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);

      // オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 1');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pump();

      // 昇順になったはず
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      await tester.pump();

      // もう一度オーダーアイコンをタップ
      await tester.runAsync<void>(() async {
        testLogger.i('Tap order toggle button 2');
        await tester.tap(find.byType(RepoOrderToggleButton));
      });
      await tester.pump();

      // 降順になったはず
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
    });
    testWidgets('ローディング中は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: RepoOrderToggleButton(),
          ),
        ),
      );

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
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: const Scaffold(
            body: RepoOrderToggleButton(),
          ),
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
    testWidgets('初期化中は無効化になるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 検索文字列を空文字にする
            repoSearchReposInitQueryProvider.overrideWithValue(''),
          ],
          home: const Scaffold(
            body: RepoOrderToggleButton(),
          ),
        ),
      );

      // 初期状態は無効化になるはず
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

      // 有効化になるはず
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
  });
}
