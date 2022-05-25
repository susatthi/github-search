// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/repo/components/repo_full_name_text.dart';
import 'package:github_search/presentation/repo/components/repo_selected_repo.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('RepoFullNameText', () {
    testWidgets('正しく表示出来るはず', (tester) async {
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
          home: const RepoFullNameText(),
        ),
      );

      // 最初はローディング含めて何も表示していないはず
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('flutter/plugins'), findsNothing);

      await tester.pump();

      // リポジトリのフルネームを表示するはず
      expect(find.byType(SizedBox), findsNothing);
      expect(find.text('flutter/plugins'), findsOneWidget);
    });
    testWidgets('エラー時は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
            repoSelectedRepoProvider.overrideWithProvider(
              repoSelectedRepoProviderFamily(
                const RepoSelectedRepoParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const RepoFullNameText(),
        ),
      );

      // 最初はローディング含めて何も表示していないはず
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('flutter/plugins'), findsNothing);

      await tester.pump();

      // エラー時は何も表示しないはず
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('flutter/plugins'), findsNothing);
    });
  });
}
