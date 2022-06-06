// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/avatar_preview_page.dart';
import 'package:github_search/presentation/pages/repo/components/selected_repo.dart';
import 'package:github_search/presentation/pages/repo/components/selected_repo_parameter.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoAvatarPreviewView', () {
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
          home: const AvatarPreviewPage(),
        ),
      );

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
          home: const AvatarPreviewPage(),
        ),
      );

      // まだ PhotoView は表示していないはず
      expect(find.byType(PhotoView), findsNothing);

      await tester.pump();

      // PhotoView を表示していないはず
      expect(find.byType(PhotoView), findsNothing);
    });
  });
}
