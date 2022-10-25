// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/state/current_repo.dart';
import 'package:github_search/presentation/page/repo/component/repo_detail_view.dart';
import 'package:github_search/presentation/page/repo/repo_view_page.dart';

import '../../../test_util/golden_testing_tools.dart';
import '../../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoViewPage', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      // リポジトリ詳細画面を表示したはず
      await tester.pumpWidget(
        agent.mockApp(
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
          home: const RepoViewPage(),
        ),
      );
      await tester.pump();

      // リポジトリのフルネーム
      expect(find.byType(RepoViewTitle), findsOneWidget);

      // リポジトリ詳細View
      expect(find.byType(SliverRepoDetailView), findsOneWidget);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.pumpDeviceBuilder(
        DeviceBuilder()
          ..addScenario(
            widget: const RepoViewPage(),
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
      await screenMatchesGolden(
        tester,
        'repo_view_page',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
