// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/components/common/avatar_preview_view.dart';
import 'package:github_search/presentation/pages/common/avatar_preview_page.dart';
import 'package:photo_view/photo_view.dart';

import '../../../test_utils/mocks.dart';

void main() {
  group('avatarPreviewUrlProvider', () {
    test('最初はStateErrorをthrowするはず', () async {
      final container = mockProviderContainer();
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(avatarPreviewUrlProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw e.exception as StateError;
        }
      };
      expect(func, throwsStateError);
    });
    test('overridesすればStateErrorをthrowしないはず', () async {
      final container = mockProviderContainer(
        overrides: [
          avatarPreviewUrlProvider.overrideWithValue('dummy'),
        ],
      );
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(avatarPreviewUrlProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw e.exception as StateError;
        }
      };
      expect(func, func);
    });
  });
  group('AvatarPreviewView', () {
    testWidgets('PhotoViewが表示されるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          overrides: [
            avatarPreviewUrlProvider.overrideWithValue('dummy'),
          ],
          home: const AvatarPreviewPage(),
        ),
      );
      expect(find.byType(PhotoView), findsOneWidget);
    });
  });
}
