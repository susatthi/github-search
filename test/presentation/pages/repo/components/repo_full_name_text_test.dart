// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/state/current_repo.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/presentation/pages/repo/components/repo_full_name_text.dart';

import '../../../../test_utils/golden_testing_tools.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('RepoFullNameText', () {
    testWidgets('正しく表示出来るはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            currentRepoProvider.overrideWithProvider(
              currentRepoProviderFamily(
                const CurrentRepoParam(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const RepoFullNameText(),
        ),
      );
      await tester.pump();

      // 最初はローディング含めて何も表示していないはず
      expect(find.text('flutter/plugins'), findsNothing);

      await tester.pump();

      // リポジトリのフルネームを表示するはず
      expect(find.text('flutter/plugins'), findsOneWidget);
    });
    testWidgets('エラー時は何も表示しないはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            // 常にエラーを返すHTTPクライアントを使う
            httpClientProvider.overrideWithValue(mockHttpClientError),
            currentRepoProvider.overrideWithProvider(
              currentRepoProviderFamily(
                const CurrentRepoParam(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: const RepoFullNameText(),
        ),
      );
      await tester.pump();

      // 最初はローディング含めて何も表示していないはず
      expect(find.text('flutter/plugins'), findsNothing);

      await tester.pump();

      // エラー時は何も表示しないはず
      expect(find.text('flutter/plugins'), findsNothing);
    });
    testDeviceGoldens('ゴールデン', (tester) async {
      await tester.pumpDeviceBuilder(
        DeviceBuilder()
          ..addScenario(
            widget: const RepoFullNameText(),
          ),
        wrapper: (child) => agent.mockApp(
          overrides: [
            currentRepoProvider.overrideWithProvider(
              currentRepoProviderFamily(
                const CurrentRepoParam(
                  ownerName: 'flutter',
                  repoName: 'plugins',
                ),
              ),
            ),
          ],
          home: Material(
            child: child,
          ),
        ),
      );
      await screenMatchesGolden(
        tester,
        'repo_full_name_text',
        customPump: (tester) async {
          await tester.pump();
        },
      );
    });
  });
}
