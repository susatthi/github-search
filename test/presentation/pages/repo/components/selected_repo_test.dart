// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/router.dart';
import 'package:github_search/infrastructure/github/repo/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';
import 'package:github_search/presentation/pages/repo/components/selected_repo.dart';

import 'package:github_search/presentation/pages/repo/repo_view_page.dart';
import 'package:go_router/go_router.dart';

import '../../../../test_utils/test_agent.dart';
import '../../../../test_utils/utils.dart';

final _extra = GitHubRepoRepository.repoBuilder(
  RepoJsonObject.fromJson(
    TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
  ),
);

class _FirstPage extends StatelessWidget {
  const _FirstPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          context.goNamed(
            'repo_view',
            params: RepoViewPage.params(
              ownerName: 'ownerName',
              repoName: 'repoName',
            ),
            extra: _extra,
          );
        },
        child: const Text('go'),
      ),
    );
  }
}

void main() {
  const repoDetailViewParameter = SelectedRepoParameter(
    ownerName: 'flutter',
    repoName: 'flutter',
  );

  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('selectedRepoProvider', () {
    test('最初はUnimplementedErrorをthrowするはず', () async {
      expect(
        () => agent.mockContainer().read(selectedRepoProvider),
        throwsUnimplementedError,
      );
    });
    test('overridesすればUnimplementedErrorをthrowしないはず', () async {
      agent.mockContainer(
        overrides: [
          selectedRepoProvider.overrideWithProvider(
            selectedRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      ).read(selectedRepoProvider);
    });
  });
  group('SelectedRepoParameter', () {
    testWidgets('from()でインスタンスが生成できるはず', (tester) async {
      await tester.pumpWidget(
        agent.mockApp(
          overrides: [
            routerProvider.overrideWithValue(
              GoRouter(
                routes: [
                  GoRoute(
                    path: '/',
                    builder: (context, state) => const _FirstPage(),
                    routes: [
                      GoRoute(
                        name: 'repo_view',
                        path: ':$pageParamKeyOwnerName/:$pageParamKeyRepoName',
                        builder: (context, state) {
                          final parameter = SelectedRepoParameter.from(state);
                          expect(parameter.ownerName, 'ownerName');
                          expect(parameter.repoName, 'repoName');
                          expect(parameter.extra, _extra);
                          return const Scaffold();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      // ボタンをタップして次の画面に遷移する
      await tester.tap(find.byType(TextButton));
      await tester.pump();
    });
  });
  group('SelectedRepoNotifier', () {
    test('Notifierを生成するとリポジトリエンティティを取得するはず', () async {
      final notifier = agent
          .mockContainer(
            overrides: [
              selectedRepoProvider.overrideWithProvider(
                selectedRepoProviderFamily(repoDetailViewParameter),
              ),
            ],
          )
          .listen(
            selectedRepoProvider.notifier,
            (previous, next) {},
          )
          .read();

      // 初期値はAsyncLoading
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncLoading, true);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncData, true);
    });
    test('extra がある場合はリポジトリエンティティを取得しないはず', () async {
      final notifier = agent
          .mockContainer(
            overrides: [
              selectedRepoProvider.overrideWithProvider(
                selectedRepoProviderFamily(
                  SelectedRepoParameter(
                    ownerName: 'flutter',
                    repoName: 'flutter',
                    extra: _extra,
                  ),
                ),
              ),
            ],
          )
          .listen(
            selectedRepoProvider.notifier,
            (previous, next) {},
          )
          .read();

      // extra があるので初期値はAsyncData
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncData, true);
    });
  });
}
