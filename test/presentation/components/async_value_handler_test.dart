// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/component/async_value_handler.dart';

import '../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('AsyncValueHandler', () {
    testWidgets('正しく表示するはず', (tester) async {
      const expectedText = 'テキスト';
      const asyncValue = AsyncValue<String>.data(expectedText);
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: AsyncValueHandler<String>(
              value: asyncValue,
              builder: Text.new,
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストが表示されるはず
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(expectedText), findsOneWidget);
    });
    testWidgets('nullは表示しないはず', (tester) async {
      const asyncValue = AsyncValue<String?>.data(null);
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: AsyncValueHandler<String>(
              value: asyncValue,
              builder: Text.new,
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストは表示されないはず
      expect(find.byType(Text), findsNothing);
    });
    testWidgets('loading中はテキストを表示しないはず', (tester) async {
      const asyncValue = AsyncValue<String>.loading();
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: AsyncValueHandler<String>(
              value: asyncValue,
              builder: Text.new,
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストは表示されないはず
      expect(find.byType(Text), findsNothing);
    });
    testWidgets('loadingを表示するはず', (tester) async {
      const asyncValue = AsyncValue<String>.loading();
      await tester.pumpWidget(
        agent.mockApp(
          home: const Scaffold(
            body: AsyncValueHandler<String>(
              value: asyncValue,
              builder: Text.new,
              loading: CircularProgressIndicator.new,
            ),
          ),
        ),
      );
      await tester.pump();

      // ローディングを表示するはず
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('error時はテキストを表示しないはず', (tester) async {
      final asyncValue = AsyncValue<String>.error(Exception());
      await tester.pumpWidget(
        agent.mockApp(
          home: Scaffold(
            body: AsyncValueHandler<String>(
              value: asyncValue,
              builder: Text.new,
            ),
          ),
        ),
      );
      await tester.pump();

      // テキストは表示されないはず
      expect(find.byType(Text), findsNothing);
    });
  });
}
