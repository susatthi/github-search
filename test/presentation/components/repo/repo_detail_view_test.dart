// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/cached_circle_avatar.dart';
import 'package:github_search/presentation/components/common/error_view.dart';
import 'package:github_search/presentation/components/repo/repo_detail_view.dart';
import 'package:github_search/presentation/components/repo/repo_detail_view_notifier.dart';

import '../../../test_utils/mocks.dart';

class _MockPage extends StatelessWidget {
  const _MockPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverRepoDetailView(),
        ],
      ),
    );
  }
}

void main() {
  group('RepoDetailView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoDetailViewStateProvider.overrideWithProvider(
              repoDetailViewStateProviderFamily(
                const RepoDetailViewParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const _MockPage(),
        ),
      );

      // まだフルネームは表示していないはず
      expect(find.text('flutter/plugins'), findsNothing);

      await tester.pump();

      // オーナー画像
      expect(find.byType(CachedCircleAvatar), findsOneWidget);

      // フルネーム
      expect(find.text('flutter/plugins'), findsOneWidget);

      // 説明
      expect(
        find.text('Plugins for Flutter maintained by the Flutter team'),
        findsOneWidget,
      );

      // プロジェクト言語
      expect(find.text('Dart'), findsOneWidget);

      // スター数
      expect(find.byIcon(Icons.star_outline), findsOneWidget);

      // ウォッチャー数
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // フォーク数
      expect(find.byIcon(Icons.fork_right_outlined), findsOneWidget);

      // Issue数
      expect(find.byIcon(Icons.bug_report_outlined), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoDetailViewStateProvider.overrideWithProvider(
              repoDetailViewStateProviderFamily(
                const RepoDetailViewParameter(
                  ownerName: 'unknown',
                  repoName: 'unknown',
                ),
              ),
            ),
          ],
          home: const _MockPage(),
        ),
      );

      // まだエラー画面は表示していないはず
      expect(find.byType(ErrorView), findsNothing);

      await tester.pump();

      // エラー画面を表示しているはず
      expect(find.byType(ErrorView), findsOneWidget);
    });
  });
}
