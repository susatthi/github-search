// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/pages/repo/repo_index_page.dart';

import '../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('GitHubSearchApp', () {
    testWidgets('起動出来るはず', (tester) async {
      await tester.pumpWidget(agent.mockApp());
      await tester.pumpAndSettle();
      expect(find.byType(RepoIndexPage), findsOneWidget);
    });
  });
}
