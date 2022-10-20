// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/pages/repo/components/repo_list_view.dart';
import 'package:github_search/presentation/pages/repo/components/search_repos_query.dart';
import 'package:github_search/presentation/widgets/error_view.dart';
import 'package:github_search/presentation/widgets/list_loader.dart';
import 'package:github_search/utils/localizations/strings.g.dart';
import 'package:github_search/utils/routing/router.dart';
import 'package:go_router/go_router.dart';
import 'package:number_display/number_display.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../test_utils/golden_testing_tools.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';

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
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('SliverRepoListView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // ローディングを表示しているはず
      expect(find.byType(ListLoader), findsOneWidget);

      await tester.pump();

      // SliverListを表示しているはず
      expect(find.byType(SliverList), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 常にエラーを発生させる
            httpClientProvider.overrideWithValue(mockHttpClientError),
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
    testWidgets('検索文字列が空の場合は検索を促す画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索文字列を空文字にする
            searchReposInitQueryProvider.overrideWithValue(''),
          ],
          home: const _MockPage(),
        ),
      );

      await tester.pump();

      // 初期状態はloadingを表示しているはず
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(ListLoader), findsOneWidget);

      // まだRepoPromptSearchViewは表示していないはず
      expect(find.byType(RepoPromptSearchView), findsNothing);

      await tester.runAsync(() async {
        await tester.pump();

        // 500ミリ秒後に透過処理があるので余裕を見て1秒遅延させる
        await Future<void>.delayed(const Duration(seconds: 1));
        await tester.pump();
      });

      // RepoPromptSearchViewを表示しているはず
      expect(find.byType(RepoPromptSearchView), findsOneWidget);
    });
    testWidgets('検索結果が0件の場合はリポジトリが見つからなかった旨を表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 検索結果0件になる検索文字列にする
            searchReposInitQueryProvider.overrideWithValue('empty'),
          ],
          home: const _MockPage(),
        ),
      );
      await tester.pump();

      // まだRepoEmptyItemsViewは表示していないはず
      expect(find.byType(RepoEmptyItemsView), findsNothing);

      await tester.pump();

      // RepoEmptyItemsViewを表示しているはず
      expect(find.byType(RepoEmptyItemsView), findsOneWidget);
    });
    testWidgets('検索結果件数を表示するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const _MockPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text(
          i18n.totalCountResult(totalCount: createDisplay()(356299)),
        ),
        findsOneWidget,
      );
    });
    testWidgets('一番下までスクロールしたら次のページを取得するはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const _MockPage(),
        ),
      );
      await tester.pumpAndSettle();

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
        agent.mockApp(
          home: InheritedGoRouter(
            goRouter: agent.mockGoRouter,
            child: const _MockPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final listView = tester.widget(find.byType(SliverRepoListViewInternal))
          as SliverRepoListViewInternal;
      final repo = listView.state.items
          .firstWhere((element) => element.fullName == 'flutter/flutter');

      final location = RepoViewRoute.from(repo).location;
      expect(agent.mockGoRouter.calledLocations.contains(location), false);

      // ListTileをタップする
      expect(find.text('flutter/flutter'), findsOneWidget);
      await tester.tap(find.text('flutter/flutter'));

      // リポジトリ詳細画面に遷移するはず
      expect(agent.mockGoRouter.calledLocations.contains(location), true);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: const _MockPage(),
            ),
          wrapper: (child) => agent.mockApp(
            home: Material(
              child: child,
            ),
          ),
        );
        await tester.pump();
      });
      await screenMatchesGolden(tester, 'repo_list_view');
    });
  });
}
