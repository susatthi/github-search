// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/router.dart';
import 'package:github_search/domain/entities/owner.dart';
import 'package:github_search/domain/entities/repo.dart';
import 'package:github_search/presentation/repo/components/selected_repo.dart';
import 'package:github_search/presentation/repo/pages/view_page.dart';
import 'package:go_router/go_router.dart';

import '../../../test_utils/locale.dart';
import '../../../test_utils/mocks.dart';

const _extra = Repo(
  name: '',
  fullName: '',
  owner: Owner(
    name: '',
    avatarUrl: '',
    ownerUrl: '',
  ),
  description: '',
  stargazersCount: 0,
  watchersCount: 0,
  language: '',
  forksCount: 0,
  openIssuesCount: 0,
  defaultBranch: '',
  repoUrl: '',
  stargazersUrl: '',
  watchersUrl: '',
  forksUrl: '',
  issuesUrl: '',
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

  setUp(useEnvironmentLocale);
  group('repoSelectedRepoProvider', () {
    test('最初はStateErrorをthrowするはず', () async {
      final container = mockProviderContainer();
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(repoSelectedRepoProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw (e.exception as ProviderException).exception;
        }
      };
      expect(func, throwsStateError);
    });
    test('overridesすればStateErrorをthrowしないはず', () async {
      final container = mockProviderContainer(
        overrides: [
          repoSelectedRepoProvider.overrideWithProvider(
            repoSelectedRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      );
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(repoSelectedRepoProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw (e.exception as ProviderException).exception;
        }
      };
      expect(func, func);
    });
  });
  group('RepoSelectedRepoParameter', () {
    testWidgets('from()でインスタンスが生成できるはず', (tester) async {
      await tester.pumpWidget(
        mockGitHubSearchApp(
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
      final container = mockProviderContainer(
        overrides: [
          repoSelectedRepoProvider.overrideWithProvider(
            repoSelectedRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      );
      final notifier = container
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
      final container = mockProviderContainer(
        overrides: [
          repoSelectedRepoProvider.overrideWithProvider(
            repoSelectedRepoProviderFamily(
              const RepoSelectedRepoParameter(
                ownerName: 'flutter',
                repoName: 'flutter',
                extra: _extra,
              ),
            ),
          ),
        ],
      );
      final notifier = container
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
