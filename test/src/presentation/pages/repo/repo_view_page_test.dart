// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/config/github_search_app.dart';
import 'package:github_search/src/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view_controller.dart';
import 'package:github_search/src/repositories/repo_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late Widget app;
  setUp(() {
    app = ProviderScope(
      overrides: [
        repoRepositoryProvider.overrideWithValue(mockGithubRepoRepository),
        repoDetailViewControllerProvider.overrideWithProvider(
          repoDetailViewControllerProviderFamily(
            const RepoDetailViewParameter(
              ownerName: 'flutter',
              repoName: 'plugins',
            ),
          ),
        ),
      ],
      child: GithubSearchApp(
        // リポジトリ詳細画面を直接表示する
        home: const RepoViewPage(),
      ),
    );
  });

  testWidgets('画面が表示され必要なWidgetが存在するはず', (tester) async {
    // リポジトリ詳細画面を表示したはず
    await tester.pumpWidget(app);
    await tester.pump();

    // オーナー名
    expect(find.text('flutter'), findsOneWidget);

    // リポジトリ名
    expect(find.text('plugins'), findsOneWidget);

    // プロジェクト言語
    expect(find.text('Dart'), findsOneWidget);
  });
}