// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/components/avatar_preview_view.dart';
import 'package:github_search/presentation/pages/repo/components/selected_repo.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../test_utils/golden_testing_tools.dart';
import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('AvatarPreviewView', () {
    testWidgets('PhotoViewが表示されるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            selectedRepoProvider.overrideWithProvider(
              selectedRepoProviderFamily(
                const SelectedRepoParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const AvatarPreviewView(),
        ),
      );
      await tester.pump();

      // まだ PhotoView は表示していないはず
      expect(find.byType(PhotoView), findsNothing);

      await tester.pump();

      // PhotoView を表示しているはず
      expect(find.byType(PhotoView), findsOneWidget);
    });
    testWidgets('エラーが発生した場合は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            selectedRepoProvider.overrideWithProvider(
              selectedRepoProviderFamily(
                const SelectedRepoParameter(
                  ownerName: 'unknown',
                  repoName: 'unknown',
                ),
              ),
            ),
          ],
          home: const AvatarPreviewView(),
        ),
      );
      await tester.pump();

      // まだ PhotoView は表示していないはず
      expect(find.byType(PhotoView), findsNothing);

      await tester.pump();

      // PhotoView を表示していないはず
      expect(find.byType(PhotoView), findsNothing);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(
          DeviceBuilder()
            ..addScenario(
              widget: const AvatarPreviewView(),
            ),
          wrapper: (child) => agent.mockApp(
            overrides: [
              selectedRepoProvider.overrideWithProvider(
                selectedRepoProviderFamily(
                  const SelectedRepoParameter(
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
        'avatar_preview_view',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
