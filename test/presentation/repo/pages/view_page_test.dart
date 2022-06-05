// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/components/detail_view.dart';
import 'package:github_search/presentation/repo/components/full_name_text.dart';
import 'package:github_search/presentation/repo/pages/view_page.dart';
import 'package:github_search/presentation/repo/state/selected_repo.dart';

import '../../../test_utils/test_agent.dart';

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
            repoSelectedRepoProvider.overrideWithProvider(
              repoSelectedRepoProviderFamily(
                const RepoSelectedRepoParameter(
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
      expect(find.byType(RepoFullNameText), findsOneWidget);

      // リポジトリ詳細View
      expect(find.byType(SliverRepoDetailView), findsOneWidget);
    });
  });
}
