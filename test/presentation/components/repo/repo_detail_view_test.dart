// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/error_view.dart';
import 'package:github_search/presentation/components/repo/repo_detail_view.dart';
import 'package:github_search/presentation/components/repo/repo_detail_view_notifier.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('RepoDetailView', () {
    testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoDetailViewStateProvider.overrideWithProvider(
              repoDetailViewStateProviderFamily(
                const RepoDetailViewParameter(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const Scaffold(
            body: RepoDetailView(),
          ),
        ),
      );

      // ローディングを表示しているはず
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // まだオーナー名は表示していないはず
      expect(find.text('flutter'), findsNothing);

      await tester.pump();

      // オーナー名
      expect(find.text('flutter'), findsOneWidget);

      // リポジトリ名
      expect(find.text('plugins'), findsOneWidget);

      // プロジェクト言語
      expect(find.text('Dart'), findsOneWidget);
    });
    testWidgets('エラーが発生した場合はエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            repoDetailViewStateProvider.overrideWithProvider(
              repoDetailViewStateProviderFamily(
                const RepoDetailViewParameter(
                  ownerName: 'unknown',
                  repoName: 'unknown',
                ),
              ),
            ),
          ],
          home: const Scaffold(
            body: RepoDetailView(),
          ),
        ),
      );

      // まだエラー画面は表示していないはず
      expect(find.byType(ErrorView), findsNothing);

      await tester.pump();

      // エラー画面を表示しているはず
      expect(find.byType(ErrorView), findsOneWidget);
    });
  });
}
