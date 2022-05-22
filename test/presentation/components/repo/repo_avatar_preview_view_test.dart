// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/repo/repo_avatar_preview_view_notifier.dart';
import 'package:github_search/presentation/components/repo/repo_detail_view_notifier.dart';
import 'package:github_search/presentation/pages/repo/repo_avatar_preview_page.dart';
import 'package:photo_view/photo_view.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('RepoAvatarPreviewView', () {
    testWidgets('PhotoViewが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoAvatarPreviewViewStateProvider.overrideWithProvider(
              repoAvatarPreviewViewStateProviderFamily(
                const RepoDetailViewParameter(
                  ownerName: 'flutter',
                  repoName: 'flutter',
                ),
              ),
            ),
          ],
          home: const RepoAvatarPreviewPage(),
        ),
      );

      await tester.pump();
      expect(find.byType(PhotoView), findsOneWidget);
    });
  });
}
