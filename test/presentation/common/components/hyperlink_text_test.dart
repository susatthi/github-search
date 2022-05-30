// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/common/components/hyperlink_text.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  late MockUrlLauncherPlatform mockUrlLauncherPlatform;
  setUp(() {
    mockUrlLauncherPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
    useEnvironmentLocale();
  });

  group('HyperlinkText', () {
    testWidgets('正しく表示するはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: expectedText,
              url: 'https://keyber.jp',
            ),
          ),
        ),
      );

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいるはず
      expect(find.byType(InkWell), findsOneWidget);
    });
    testWidgets('タップでURL起動ができるはず', (tester) async {
      const urlString = 'https://github.com';

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

      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: 'リンク',
              url: urlString,
            ),
          ),
        ),
      );

      // タップする
      await tester.tap(find.byType(HyperlinkText));
      await tester.pump();

      // URL起動出来ているはず
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
    testWidgets('不正なURLならSnackBarが表示されるはず', (tester) async {
      const urlString = 'https://999.168.0.1/';

      // URL起動失敗を返す
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
      ).thenAnswer((_) async => false);

      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: 'リンク',
              url: urlString,
            ),
          ),
        ),
      );

      // SnackBarはいないはず
      expect(find.byType(SnackBar), findsNothing);

      // タップする
      await tester.tap(find.byType(HyperlinkText));
      await tester.pump();

      // URL起動を試みているはず
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

      // SnackBarがいるはず
      expect(find.byType(SnackBar), findsOneWidget);
    });
    testWidgets('urlがnullならアンカー表示しないはず', (tester) async {
      const expectedText = 'リンク';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: HyperlinkText(
              text: expectedText,
            ),
          ),
        ),
      );

      // テキストが表示されるはず
      expect(find.text(expectedText), findsOneWidget);

      // InkWellがいないはず
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
