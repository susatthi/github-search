// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view_controller.dart';
import 'package:github_search/src/repositories/repo_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  const repoDetailViewParameter = RepoDetailViewParameter(
    ownerName: 'flutter',
    repoName: 'flutter',
  );

  group('Provider', () {
    test('repoDetailViewControllerProviderは最初はStateErrorをthrowするはず', () async {
      final container = ProviderContainer();
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(repoDetailViewControllerProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw (e.exception as ProviderException).exception;
        }
      };
      expect(func, throwsStateError);
    });
    test('overridesすればStateErrorをthrowしないはず', () async {
      final container = ProviderContainer(
        overrides: [
          repoDetailViewControllerProvider.overrideWithProvider(
            repoDetailViewControllerProviderFamily(repoDetailViewParameter),
          ),
        ],
      );
      // ignore: prefer_function_declarations_over_variables
      final func = () {
        try {
          container.read(repoDetailViewControllerProvider);
        } on ProviderException catch (e) {
          // ignore: only_throw_errors
          throw (e.exception as ProviderException).exception;
        }
      };
      expect(func, func);
    });
  });
  group('RepoDetailViewController', () {
    test('Controllerを生成するとリポジトリエンティティを取得するはず', () async {
      final container = ProviderContainer(
        overrides: [
          repoRepositoryProvider.overrideWithValue(mockGithubRepoRepository),
          repoDetailViewControllerProvider.overrideWithProvider(
            repoDetailViewControllerProviderFamily(repoDetailViewParameter),
          ),
        ],
      );
      final controller = container
          .listen(
            repoDetailViewControllerProvider.notifier,
            (previous, next) {},
          )
          .read();
      // 初期値はAsyncLoading
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(controller.state is AsyncLoading, true);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(controller.state is AsyncData, true);
    });
  });
}
