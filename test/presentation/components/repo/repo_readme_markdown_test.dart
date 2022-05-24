// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/entities/repo/repo_data.dart';
import 'package:github_search/presentation/components/repo/repo_readme_markdown.dart';
import 'package:github_search/repositories/github/http_client.dart';
import 'package:lottie/lottie.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../test_utils/mocks.dart';
import '../../../test_utils/utils.dart';

void main() {
  late RepoData repo;
  late MockUrlLauncherPlatform mockUrlLauncherPlatform;
  setUp(() {
    repo = RepoData.from(
      Repo.fromJson(
        TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
      ),
    );
    mockUrlLauncherPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
  });

  group('RepoReadmeMarkdown', () {
    testWidgets('必要なWidgetが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      // 最初はローディングを表示するはず
      expect(find.byType(LottieBuilder), findsOneWidget);
      expect(find.byType(MarkdownBody), findsNothing);

      await tester.pump();

      // Markdownを表示するはず
      expect(find.byType(LottieBuilder), findsNothing);
      expect(find.byType(MarkdownBody), findsOneWidget);
    });
    testWidgets('通信エラー時は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
          ],
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      // 最初はローディングを表示するはず
      expect(find.byType(LottieBuilder), findsOneWidget);
      expect(find.byType(MarkdownBody), findsNothing);

      await tester.pump();

      // Markdownを表示しないはず
      expect(find.byType(LottieBuilder), findsNothing);
      expect(find.byType(MarkdownBody), findsNothing);
    });
    testWidgets('リンクをタップしてブラウザを開けるはず', (tester) async {
      const urlString = 'https://keyber.jp/';
      when(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => true);

      final repo = RepoData.from(
        Repo.fromJson(
          TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
        ),
      );
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: SingleChildScrollView(
            child: RepoReadmeMarkdown(repo: repo),
          ),
        ),
      );

      await tester.pump();

      // リンクをタップする
      await tester.tap(find.text('リンク'));
      await tester.pump();

      verify(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).called(1);
    });
  });
}
