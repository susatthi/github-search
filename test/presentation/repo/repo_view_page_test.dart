// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/components/repo_detail_view.dart';
import 'package:github_search/presentation/repo/components/repo_full_name_text.dart';
import 'package:github_search/presentation/repo/components/repo_selected_repo.dart';
import 'package:github_search/presentation/repo/repo_view_page.dart';

import '../../test_utils/locale.dart';
import '../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('RepoViewPage', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      // リポジトリ詳細画面を表示したはず
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
