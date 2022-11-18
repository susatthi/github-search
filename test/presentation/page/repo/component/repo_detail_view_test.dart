// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/application/repo/state/current_repo.dart';
import 'package:github_search/domain/repository/repo/entity/repo.dart';
import 'package:github_search/domain/repository/repo/entity/repo_param.dart';
import 'package:github_search/presentation/component/cached_circle_avatar.dart';
import 'package:github_search/presentation/component/error_view.dart';
import 'package:github_search/presentation/page/repo/component/readme_markdown.dart';
import 'package:github_search/presentation/page/repo/component/repo_detail_view.dart';
import 'package:github_search/util/routing/router.dart';
import 'package:go_router/go_router.dart';

import '../../../../test_util/golden_testing_tools.dart';
import '../../../../test_util/test_agent.dart';

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
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  /// ハイパーリンクをタップするテスト
  Future<void> wrapTapHyperlinkTest(
    WidgetTester tester,
    Finder tapTarget,
    String Function(Repo data) urlSelector,
  ) async {
    await tester.pumpWidget(
      agent.mockApp(
        overrides: [
          currentRepoParamProvider.overrideWithValue(
            const RepoParam(
              ownerName: 'flutter',
              repoName: 'plugins',
            ),
          ),
        ],
        home: const _MockPage(),
      ),
    );

    await tester.pump();
    await tester.pump();

    // ブラウザで表示するURLを決定する
    final repoDetailViewInternal =
        tester.widget(find.byType(SliverRepoDetailViewInternal))
            as SliverRepoDetailViewInternal;
    final data = repoDetailViewInternal.repo;
    final url = urlSelector(data);

    expect(
      agent.mockUrlLauncherPlatform.calledUrls.contains(url),
      false,
    );

    // ターゲットをタップする
    await tester.tap(tapTarget);
    await tester.pump();

    expect(
      agent.mockUrlLauncherPlatform.calledUrls.contains(url),
      true,
    );
  }

  group('RepoDetailView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            currentRepoParamProvider.overrideWithValue(
              const RepoParam(
                ownerName: 'flutter',
                repoName: 'plugins',
              ),
            ),
          ],
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // まだオーナー名は表示していないはず
      expect(find.text('flutter'), findsNothing);

      await tester.pump();

      // オーナー画像
      expect(find.byType(CachedCircleAvatar), findsOneWidget);

      // オーナー名
      expect(find.text('flutter'), findsOneWidget);

      // リポジトリ名
      expect(find.text('plugins'), findsOneWidget);

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

      // README
      expect(find.byType(ReadmeMarkdown), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            currentRepoParamProvider.overrideWithValue(
              const RepoParam(
                ownerName: 'unknown',
                repoName: 'unknown',
              ),
            ),
          ],
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // まだエラー画面は表示していないはず
      expect(find.byType(ErrorView), findsNothing);

      await tester.pump();

      // エラー画面を表示しているはず
      expect(find.byType(ErrorView), findsOneWidget);
    });
    testWidgets('オーナー名のリンクをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.text('flutter'),
        (data) => data.ownerUrl!,
      );
    });
    testWidgets('リポジトリ名のリンクをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.text('plugins'),
        (data) => data.repoUrl!,
      );
    });
    testWidgets('スター数のアイコンボタンをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.byIcon(Icons.star_outline),
        (data) => data.stargazersUrl!,
      );
    });
    testWidgets('ウォッチャー数のアイコンボタンをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.byIcon(Icons.visibility_outlined),
        (data) => data.watchersUrl!,
      );
    });
    testWidgets('フォーク数のアイコンボタンをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.byIcon(Icons.fork_right_outlined),
        (data) => data.forksUrl!,
      );
    });
    testWidgets('Issue数のアイコンボタンをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.byIcon(Icons.bug_report_outlined),
        (data) => data.issuesUrl!,
      );
    });
    testWidgets('アバター画像をタップしてプレビューが開くはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            currentRepoParamProvider.overrideWithValue(
              const RepoParam(
                ownerName: 'flutter',
                repoName: 'plugins',
              ),
            ),
          ],
          home: InheritedGoRouter(
            goRouter: agent.mockGoRouter,
            child: const _MockPage(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      final detailView =
          tester.widget(find.byType(SliverRepoDetailViewInternal))
              as SliverRepoDetailViewInternal;
      final repo = detailView.repo;

      final location = AvatarPreviewRoute.from(repo).location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // アバター画像をタップする
      await tester.tap(find.byType(CachedCircleAvatar));

      // プレビュー画面に画面遷移するはず
      expect(agent.mockGoRouter.calledLocations.contains(location), true);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.pumpDeviceBuilder(
        DeviceBuilder()
          ..addScenario(
            widget: const _MockPage(),
          ),
        wrapper: (child) => agent.mockApp(
          overrides: [
            currentRepoParamProvider.overrideWithValue(
              const RepoParam(
                ownerName: 'flutter',
                repoName: 'plugins',
              ),
            ),
          ],
          home: Material(
            child: child,
          ),
        ),
      );
      await screenMatchesGolden(
        tester,
        'repo_detail_view',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
