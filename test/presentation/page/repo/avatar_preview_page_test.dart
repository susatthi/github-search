// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/state/current_repo.dart';
import 'package:github_search/presentation/page/repo/avatar_preview_page.dart';
import 'package:github_search/presentation/page/repo/repo_view_page.dart';

import '../../../test_util/golden_testing_tools.dart';
import '../../../test_util/mocks.dart';
import '../../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('AvatarPreviewPage', () {
    testWidgets('表示してタップで閉じるはず', (tester) async {
      await fakeSvg(() async {
        await tester.pumpWidget(agent.mockApp());
        await tester.pumpAndSettle();

        expect(find.text('flutter/plugins'), findsOneWidget);

        // リポジトリListTileをタップする
        await tester.tap(find.text('flutter/plugins'));
        await tester.pump();

        // 詳細画面に遷移したはず
        await tester.pump();
        expect(find.byType(RepoViewPage), findsOneWidget);

        // アバター画像をタップする
        await tester.tap(find.byKey(const Key('repo_detail_view#_AvatarRow')));
        await tester.pump();

        // アバタープレビュー画面に遷移するはず
        await tester.pump();
        expect(find.byType(AvatarPreviewPage), findsOneWidget);

        // 適当にタップする
        await tester.tap(find.byType(AvatarPreviewPage));
        await tester.pump();

        // アバタープレビュー画面が閉じるはず
        expect(find.byType(AvatarPreviewPage), findsNothing);
      });
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: const AvatarPreviewPage(),
            ),
          wrapper: (child) => agent.mockApp(
            overrides: [
              currentRepoProvider.overrideWithProvider(
                currentRepoProviderFamily(
                  const CurrentRepoParam(
                    ownerName: 'flutter',
                    repoName: 'plugins',
                  ),
                ),
              ),
            ],
            home: Material(
              child: child,
            ),
          ),
        );
        await tester.pump();
      });
      await screenMatchesGolden(
        tester,
        'avatar_preview_page',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
