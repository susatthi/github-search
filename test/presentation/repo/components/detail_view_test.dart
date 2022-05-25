// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repo/entities/repo_data.dart';
import 'package:github_search/presentation/common/components/cached_circle_avatar.dart';
import 'package:github_search/presentation/common/components/error_view.dart';
import 'package:github_search/presentation/repo/avatar_preview_page.dart';
import 'package:github_search/presentation/repo/components/detail_view.dart';
import 'package:github_search/presentation/repo/components/readme_markdown.dart';
import 'package:github_search/presentation/repo/components/selected_repo.dart';
import 'package:github_search/presentation/repo/view_page.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../test_utils/locale.dart';
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
  late MockUrlLauncherPlatform mockUrlLauncherPlatform;
  late MockGoRouter mockGoRouter;
  setUp(() {
    mockUrlLauncherPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
    mockGoRouter = MockGoRouter();
    useEnvironmentLocale();
  });

  /// ハイパーリンクをタップするテスト
  Future<void> wrapTapHyperlinkTest(
    WidgetTester tester,
    Finder tapTarget,
    String Function(RepoData data) urlSelector,
  ) async {
    await tester.pumpWidget(
      mockGitHubSearchApp(
        overrides: [
          repoSelectedRepoProvider.overrideWithProvider(
            repoSelectedRepoProviderFamily(
              const RepoSelectedRepoParameter(
                ownerName: 'flutter',
                repoName: 'plugins',
              ),
            ),
          ),
        ],
        home: const _MockPage(),
      ),
    );

    await tester.pump();

    // ブラウザで表示するURLを決定する
    final repoDetailViewInternal =
        tester.widget(find.byType(SliverRepoDetailViewInternal))
            as SliverRepoDetailViewInternal;
    final data = repoDetailViewInternal.repo;
    final url = urlSelector(data);

    when(
      () => mockUrlLauncherPlatform.launch(
        url,
        useSafariVC: true,
        useWebView: true,
        enableJavaScript: true,
        enableDomStorage: true,
        universalLinksOnly: false,
        headers: {},
      ),
    ).thenAnswer((_) async => true);

    // ターゲットをタップする
    await tester.tap(tapTarget);
    await tester.pump();

    verify(
      () => mockUrlLauncherPlatform.launch(
        url,
        useSafariVC: true,
        useWebView: true,
        enableJavaScript: true,
        enableDomStorage: true,
        universalLinksOnly: false,
        headers: {},
      ),
    ).called(1);
  }

  group('RepoDetailView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoSelectedRepoProvider.overrideWithProvider(
              repoSelectedRepoProviderFamily(
                const RepoSelectedRepoParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const _MockPage(),
        ),
      );

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
      expect(find.byType(RepoReadmeMarkdown), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoSelectedRepoProvider.overrideWithProvider(
              repoSelectedRepoProviderFamily(
                const RepoSelectedRepoParameter(
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
    testWidgets('オーナー名のリンクをタップしてブラウザで開くはず', (tester) async {
      await wrapTapHyperlinkTest(
        tester,
        find.text('flutter'),
        (data) => data.owner.ownerUrl!,
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
        mockGitHubSearchApp(
          overrides: [
            repoSelectedRepoProvider.overrideWithProvider(
              repoSelectedRepoProviderFamily(
                const RepoSelectedRepoParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const _MockPage(),
          ),
        ),
      );

      await tester.pump();

      final detailView =
          tester.widget(find.byType(SliverRepoDetailViewInternal))
              as SliverRepoDetailViewInternal;
      final data = detailView.repo;

      verifyNever(
        () => mockGoRouter.goNamed(
          RepoAvatarPreviewPage.name,
          params: RepoViewPage.params(
            ownerName: 'flutter',
            repoName: 'plugins',
          ),
          extra: data,
        ),
      );

      // アバター画像をタップする
      await tester.tap(find.byType(CachedCircleAvatar));

      // プレビュー画面に画面遷移するはず
      verify(
        () => mockGoRouter.goNamed(
          RepoAvatarPreviewPage.name,
          params: RepoViewPage.params(
            ownerName: 'flutter',
            repoName: 'plugins',
          ),
          extra: data,
        ),
      ).called(1);
    });
  });
}
