// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/router.dart';
import 'package:github_search/infrastructure/github/json_object/repo/repo.dart';
import 'package:github_search/infrastructure/github/repo_repository.dart';
import 'package:github_search/presentation/repo/pages/view_page.dart';
import 'package:github_search/presentation/repo/state/selected_repo.dart';
import 'package:go_router/go_router.dart';

import '../../../test_utils/test_agent.dart';
import '../../../test_utils/utils.dart';

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
  const repoDetailViewParameter = RepoSelectedRepoParameter(
    ownerName: 'flutter',
    repoName: 'flutter',
  );

  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('repoSelectedRepoProvider', () {
    test('最初はStateErrorをthrowするはず', () async {
      expect(
        () => agent.mockContainer().read(repoSelectedRepoProvider),
        throwsStateError,
      );
    });
    test('overridesすればStateErrorをthrowしないはず', () async {
      agent.mockContainer(
        overrides: [
          repoSelectedRepoProvider.overrideWithProvider(
            repoSelectedRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      ).read(repoSelectedRepoProvider);
    });
  });
  group('RepoSelectedRepoParameter', () {
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
                          final parameter =
                              RepoSelectedRepoParameter.from(state);
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
  group('RepoSelectedRepoNotifier', () {
    test('Notifierを生成するとリポジトリエンティティを取得するはず', () async {
      final notifier = agent
          .mockContainer(
            overrides: [
              repoSelectedRepoProvider.overrideWithProvider(
                repoSelectedRepoProviderFamily(repoDetailViewParameter),
              ),
            ],
          )
          .listen(
            repoSelectedRepoProvider.notifier,
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
              repoSelectedRepoProvider.overrideWithProvider(
                repoSelectedRepoProviderFamily(
                  RepoSelectedRepoParameter(
                    ownerName: 'flutter',
                    repoName: 'flutter',
                    extra: _extra,
                  ),
                ),
              ),
            ],
          )
          .listen(
            repoSelectedRepoProvider.notifier,
            (previous, next) {},
          )
          .read();

      // extra があるので初期値はAsyncData
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncData, true);
    });
  });
}
