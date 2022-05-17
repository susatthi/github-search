// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/error_view.dart';
import 'package:github_search/presentation/components/common/list_loader.dart';
import 'package:github_search/presentation/components/repo/repo_list_view.dart';
import 'package:github_search/presentation/components/repo/repo_search_repos_query.dart';
import 'package:github_search/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../test_utils/hive.dart';
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

      await tester.pump();

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
    testWidgets('一番下までスクロールしたら次のページを取得するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      expect(find.text('flutter/flutter'), findsOneWidget);
      expect(find.text('mahmudahsan/flutter'), findsNothing);

      // 一番下までスクロールする
      await _doScroll(
        tester,
        find.byType(CustomScrollView),
        const Offset(0, 10000),
      );
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

      verifyNever(
        () => mockGoRouter.goNamed(
          RepoViewPage.name,
          params: RepoViewPage.params(
            ownerName: 'flutter',
            repoName: 'flutter',
          ),
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
        ),
      ).called(1);
    });
  });
}

/// Scrolls the specified widget by the specified offset and waits sufficiently
/// long for the [VisibilityDetector] callbacks to fire.
///
/// see: https://github.com/google/flutter.widgets/blob/master/packages/visibility_detector/test/widget_test.dart
Future<void> _doScroll(
  WidgetTester tester,
  Finder finder,
  Offset scrollOffset,
) async {
  // The scroll direction is the opposite of the direction to drag.  We also
  // must drag by [kDragSlopDefault] first to start the drag.
  final dragOffset = -Offset.fromDirection(
    scrollOffset.direction,
    scrollOffset.distance + kDragSlopDefault,
  );
  await tester.drag(finder, dragOffset);

  // Wait for the drag to complete.
  await tester.pumpAndSettle();

  // Wait for callbacks to fire.
  await tester.pump(VisibilityDetectorController.instance.updateInterval);
}
