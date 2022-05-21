// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/preview_avatar_view.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('PreviewAvatarView', () {
    testWidgets('ダイアログ表示してタップで閉じるはず', (tester) async {
      const url = 'dummy';
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) => const PreviewAvatarView(url: url),
                ),
                child: const Text('ボタン'),
              );
            },
          ),
        ),
      );

      await tester.pump();

      // ボタンをタップする
      await tester.tap(find.text('ボタン'));
      await tester.pump();

      // プレビューViewが表示するはず
      expect(find.byType(PreviewAvatarView), findsOneWidget);

      // タップする
      await tester.tap(find.byType(PreviewAvatarView));
      await tester.pump();

      // プレビューViewが閉じるはず
      expect(find.byType(PreviewAvatarView), findsNothing);
    });
  });
}
