// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/repo/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';
import 'package:github_search/presentation/pages/repo/components/selected_repo.dart';

import '../../../../test_utils/test_agent.dart';
import '../../../../test_utils/utils.dart';

final _extra = GitHubRepoRepository.repoBuilder(
  RepoJsonObject.fromJson(
    TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
  ),
);

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
  group('SelectedRepoNotifier', () {
    test('Notifierを生成するとリポジトリエンティティを取得するはず', () async {
      final state = agent
          .mockContainer(
            overrides: [
              selectedRepoProvider.overrideWithProvider(
                selectedRepoProviderFamily(repoDetailViewParameter),
              ),
            ],
          )
          .listen(
            selectedRepoProvider,
            (previous, next) {},
          )
          .read();

      // 初期値はAsyncLoading
      expect(state is AsyncLoading, true);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      expect(state is AsyncData, true);
    });
    test('extra がある場合はリポジトリエンティティを取得しないはず', () async {
      final state = agent
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
            selectedRepoProvider,
            (previous, next) {},
          )
          .read();

      // extra があるので初期値はAsyncData
      expect(state is AsyncData, true);
    });
  });
}
