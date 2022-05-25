// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/common/components/error_view.dart';
import 'package:github_search/presentation/common/components/list_loader.dart';
import 'package:github_search/presentation/repo/components/list_view.dart';
import 'package:github_search/presentation/repo/pages/view_page.dart';
import 'package:github_search/presentation/repo/state/search_repos_query.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_display/number_display.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../test_utils/hive.dart';
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
          SliverRepoListView(),
        ],
      ),
    );
  }
}

void main() {
  late Directory tmpDir;
  late MockGoRouter mockGoRouter;
  setUp(() async {
    tmpDir = await openAppDataBox();
    mockGoRouter = MockGoRouter();
    useEnvironmentLocale();
  });
  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('SliverRepoListView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const _MockPage(),
        ),
      );

      // ローディングを表示しているはず
      expect(find.byType(ListLoader), findsOneWidget);

      await tester.pump();

      // SliverListを表示しているはず
      expect(find.byType(SliverList), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを発生させる
            httpClientProvider.overrideWithValue(mockHttpClientError),
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
    testWidgets('検索文字列が空の場合は検索を促す画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 検索文字列を空文字にする
            repoSearchReposInitQueryProvider.overrideWithValue(''),
          ],
          home: const _MockPage(),
        ),
      );

      // 初期状態はasyncValueがnullで中身が空のはず
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      final remaining = tester
          .widgetList(find.byType(SliverFillRemaining))
          .first as SliverFillRemaining;
      expect(remaining.child, isNull);

      // まだRepoPromptSearchViewは表示していないはず
      expect(find.byType(RepoPromptSearchView), findsNothing);

      await tester.runAsync(() async {
        await tester.pump();
      });

      // RepoPromptSearchViewを表示しているはず
      expect(find.byType(RepoPromptSearchView), findsOneWidget);
    });
    testWidgets('検索結果が0件の場合はリポジトリが見つからなかった旨を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 検索結果0件になる検索文字列にする
            repoSearchReposInitQueryProvider.overrideWithValue('empty'),
          ],
          home: const _MockPage(),
        ),
      );

      // まだRepoEmptyItemsViewは表示していないはず
      expect(find.byType(RepoEmptyItemsView), findsNothing);

      await tester.pump();

      // RepoEmptyItemsViewを表示しているはず
      expect(find.byType(RepoEmptyItemsView), findsOneWidget);
    });
    testWidgets('検索結果件数を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      expect(
        find.text(
          i18n.totalCountResult(totalCount: createDisplay()(356299)),
        ),
        findsOneWidget,
      );
    });
    testWidgets('一番下までスクロールしたら次のページを取得するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // 1ページ目の項目が表示されているはず
      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('mahmudahsan/flutter'), findsNothing);

      // VisibilityDetector が見えるまで下にスクロールする
      await tester.dragUntilVisible(
        find.byType(VisibilityDetector),
        find.byType(CustomScrollView),
        const Offset(0, -1000),
      );
      await tester.pumpAndSettle();

      // VisibilityDetector 内部でタイマー起動しているのでその分待つ必要がある
      await tester.pump(VisibilityDetectorController.instance.updateInterval);

      // 2ページ目の項目が表示されているはず
      expect(find.text('flutter/flutter'), findsNothing);
      expect(find.text('mahmudahsan/flutter'), findsOneWidget);
    });

    testWidgets('ListTileをタップしたらリポジトリ詳細画面に遷移するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: InheritedGoRouter(
            goRouter: mockGoRouter,
            child: const _MockPage(),
          ),
        ),
      );

      await tester.pump();

      final listView = tester.widget(find.byType(SliverRepoListViewInternal))
          as SliverRepoListViewInternal;
      final data = listView.state.items
          .firstWhere((element) => element.fullName == 'flutter/flutter');

      verifyNever(
        () => mockGoRouter.goNamed(
          RepoViewPage.name,
          params: RepoViewPage.params(
            ownerName: 'flutter',
            repoName: 'flutter',
          ),
          extra: data,
        ),
      );

      // ListTileをタップする
      expect(find.text('flutter/flutter'), findsOneWidget);
      await tester.tap(find.text('flutter/flutter'));

      // リポジトリ詳細画面に遷移するはず
      verify(
        () => mockGoRouter.goNamed(
          RepoViewPage.name,
          params: RepoViewPage.params(
            ownerName: 'flutter',
            repoName: 'flutter',
          ),
          extra: data,
        ),
      ).called(1);
    });
  });
}
