// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/page/error/error_page.dart';
import 'package:github_search/util/localization/strings.g.dart';

import '../../../test_utils/golden_testing_tools.dart';
import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('ErrorPage', () {
    testWidgets('errorがnullでも問題ないはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          home: const ErrorPage(),
        ),
      );
      await tester.pump();

      expect(find.text(i18n.errorOccurred), findsOneWidget);
    });
    testWidgets('errorがある場合でも問題ないはず', (tester) async {
      final error = Exception('dummy');
      await tester.pumpWidget(
        agent.mockApp(
          home: ErrorPage(
            error: error,
          ),
        ),
      );
      await tester.pump();

      expect(find.text(error.toString()), findsOneWidget);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      final error = Exception('dummy');
      await tester.pumpDeviceBuilder(
        DeviceBuilder()
          ..addScenario(
            widget: ErrorPage(
              error: error,
            ),
          ),
        wrapper: (child) => agent.mockApp(
          home: Material(
            child: child,
          ),
        ),
      );
      await screenMatchesGolden(
        tester,
        'error_page',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
