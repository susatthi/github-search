// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/repo/repo_search_text_button.dart';

import '../../../test_utils/mocks.dart';

void main() {
  // ボタン押下の画面遷移のテストは画面側で実施する

  group('RepoSearchTextButton', () {
    testWidgets('prefixIconが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: RepoSearchTextButton(),
          ),
        ),
      );

      // prefixIconが表示されるはず
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });
}
