// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/component/search_app_bar.dart';

import '../../test_util/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('SearchAppBar', () {
    testWidgets('デフォルトのAppBarの高さが意図した高さであるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: CustomScrollView(
              slivers: [
                SearchAppBar(
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SliverAppBar), findsOneWidget);
      final sliverAppBar =
          tester.widgetList(find.byType(SliverAppBar)).first as SliverAppBar;

      // AppBarの高さが意図した高さであるはず
      expect(sliverAppBar.toolbarHeight, SearchAppBar.defaultToolBarHeight);
    });
  });
}
