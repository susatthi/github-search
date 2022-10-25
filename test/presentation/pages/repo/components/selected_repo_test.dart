// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/repo/entity/repo.dart';
import 'package:github_search/domain/state/current_repo.dart';
import 'package:github_search/infrastructure/github/repo/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';

import '../../../../test_utils/test_agent.dart';
import '../../../../test_utils/utils.dart';

final _extra = GitHubRepoRepository.repoBuilder(
  RepoJsonObject.fromJson(
    TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
  ),
);

void main() {
  const repoDetailViewParameter = CurrentRepoParam(
    ownerName: 'flutter',
    repoName: 'flutter',
  );

  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('currentRepoProvider', () {
    test('最初はUnimplementedErrorをthrowするはず', () async {
      expect(
        () => agent.mockContainer().read(currentRepoProvider.future),
        throwsUnimplementedError,
      );
    });
    test('overridesすればUnimplementedErrorをthrowしないはず', () async {
      await agent.mockContainer(
        overrides: [
          currentRepoProvider.overrideWithProvider(
            currentRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      ).read(currentRepoProvider.future);
    });
  });
  group('currentRepoProvider', () {
    test('プロバイダーからリポジトリエンティティが取得できるはず', () async {
      AsyncValue<Repo>? state;
      agent.mockContainer(
        overrides: [
          currentRepoProvider.overrideWithProvider(
            currentRepoProviderFamily(repoDetailViewParameter),
          ),
        ],
      ).listen(
        currentRepoProvider,
        (previous, next) {
          state = next;
        },
      ).read();

      expect(state, null);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      expect(state is AsyncData, true);
    });
    test('extra がある場合はリポジトリエンティティを取得しないはず', () async {
      AsyncValue<Repo>? state;
      agent.mockContainer(
        overrides: [
          currentRepoProvider.overrideWithProvider(
            currentRepoProviderFamily(
              CurrentRepoParam(
                ownerName: 'flutter',
                repoName: 'flutter',
                extra: _extra,
              ),
            ),
          ),
        ],
      ).listen(
        currentRepoProvider,
        (previous, next) {
          state = next;
        },
      ).read();

      expect(state, null);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが extra と同じはず
      expect(state is AsyncData, true);
      expect(state?.value, _extra);
    });
  });
}
