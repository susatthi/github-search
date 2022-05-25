// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/common/components/list_loader.dart';
import 'package:shimmer/shimmer.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

void main() {
  setUp(useEnvironmentLocale);
  group('ListLoader', () {
    testWidgets('引数無しで意図して動作するはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: ListLoader(),
          ),
        ),
      );

      // Shimmer Widget を使っているはず
      expect(find.byType(Shimmer), findsOneWidget);

      // CircleAvatarの個数が正しいはず
      expect(find.byType(CircleAvatar), findsNWidgets(ListLoader.itemCount));

      // LoaderBoneの個数が正しいはず
      expect(
        find.byType(LoaderBone),
        findsNWidgets(ListLoader.itemCount * ListLoader.boneItemCount),
      );

      // CircleAvatarのradiusが正しいはず
      final avatar =
          tester.widgetList(find.byType(CircleAvatar)).first as CircleAvatar;
      expect(avatar.radius, 56 / 2);
    });
    testWidgets('avatarSizeが正しく反映されるはず', (tester) async {
      const avatarSize = 40.0;
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: const Scaffold(
            body: ListLoader(
              avatarSize: avatarSize,
            ),
          ),
        ),
      );

      // CircleAvatarのradiusが正しいはず
      final avatar =
          tester.widgetList(find.byType(CircleAvatar)).first as CircleAvatar;
      expect(avatar.radius, avatarSize / 2);
    });
    testWidgets('keyからWidgetが取得出来るはず', (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: Scaffold(
            body: ListLoader(
              key: key,
            ),
          ),
        ),
      );
      expect(key.currentWidget.runtimeType.toString(), 'ListLoader');
    });
  });
  group('LoaderBone', () {
    testWidgets('keyからWidgetが取得出来るはず', (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(
        mockGitHubSearchApp(
          home: LoaderBone(
            key: key,
          ),
        ),
      );
      expect(key.currentWidget.runtimeType.toString(), 'LoaderBone');
    });
  });
}
