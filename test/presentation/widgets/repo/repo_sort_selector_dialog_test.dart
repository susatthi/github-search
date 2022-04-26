// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/github_search_app.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_text_field.dart';
import 'package:github_search/presentation/widgets/repo/repo_sort_selector_dialog.dart';
import 'package:github_search/repositories/repo_repository.dart';
import 'package:github_search/utils/extensions.dart';

import '../../../test_utils/logger.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(() async {
    await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox();
  });

  group('RepoSortSelectorDialog', () {
    testWidgets('各選択肢を選択してソートが変更されるはず', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // モック版のGitHubHttpClientを使う
            repoRepositoryProvider.overrideWithValue(mockGitHubRepoRepository),
            // リポジトリ検索文字列の初期値を設定する
            searchReposQueryProvider.overrideWithProvider(
              StateProvider<String>((ref) => 'flutter'),
            ),
          ],
          child: GitHubSearchApp(
            home: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => const RepoSortSelectorDialog(),
                  ),
                  child: const Text('button'),
                );
              },
            ),
          ),
        ),
      );
      await tester.pump();

      // ダイアログを表示する
      await tester.tap(find.text('button'));
      await tester.pump();

      // 4つの選択肢が表示されているはず
      expect(find.text(i18n.bestMatch), findsOneWidget);
      expect(find.text(i18n.starsCount), findsOneWidget);
      expect(find.text(i18n.forksCount), findsOneWidget);
      expect(find.text(i18n.helpWantedIssuesCount), findsOneWidget);

      // 初期値はベストマッチのはず
      _expectListTile(tester, i18n.bestMatch);

      // スター数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at starsCount');
        await tester.tap(find.text(i18n.starsCount));
      });
      await tester.pump();

      // ダイアログを表示する
      await tester.tap(find.text('button'));
      await tester.pump();

      // スター数に変更されているはず
      _expectListTile(tester, i18n.starsCount);

      // フォーク数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at forksCount');
        await tester.tap(find.text(i18n.forksCount));
      });
      await tester.pump();

      // ダイアログを表示する
      await tester.tap(find.text('button'));
      await tester.pump();

      // フォーク数に変更されているはず
      _expectListTile(tester, i18n.forksCount);

      // ヘルプ数をタップして閉じる
      await tester.runAsync<void>(() async {
        testLogger.i('Tap ListTile at helpWantedIssuesCount');
        await tester.tap(find.text(i18n.helpWantedIssuesCount));
      });
      await tester.pump();

      // ダイアログを表示する
      await tester.tap(find.text('button'));
      await tester.pump();

      // ヘルプ数に変更されているはず
      _expectListTile(tester, i18n.helpWantedIssuesCount);
    });
  });
}

/// RepoSortSelectorDialog の項目にチェックがついているかどうかを検査する
void _expectListTile(WidgetTester tester, String checkedText) {
  // checkedText をもつ Text が1ついるはず
  expect(find.text(checkedText), findsOneWidget);

  // checkedText をもつ ListTile を1つ取り出す
  final listTile =
      tester.widgetList<ListTile>(find.byType(ListTile)).firstWhereOrNull(
            (listTile) => (listTile.title as Text?)?.data == checkedText,
          );
  expect(listTile, isNotNull);

  // ListTile の leading（Visibility）を取り出せるはず
  final visibility = listTile!.leading as Visibility?;
  expect(visibility, isNotNull);

  // Visibility から Icon を取り出せるはず
  final icon = visibility!.child as Icon?;
  expect(icon, isNotNull);
  expect(icon!.icon, Icons.check);
}
