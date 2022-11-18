// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/application/repo/state/current_repo.dart';
import 'package:github_search/domain/repository/repo/entity/repo.dart';
import 'package:github_search/domain/repository/repo/entity/repo_param.dart';
import 'package:github_search/infrastructure/github/repo/json_object/repo.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';

import '../../../../test_util/test_agent.dart';
import '../../../../test_util/utils.dart';

final _extra = GitHubRepoRepository.repoBuilder(
  RepoJsonObject.fromJson(
    TestAssets.readJsonMap('github/get_repo_flutter_plugins.json')!,
  ),
);

void main() {
  const repoDetailViewParameter = RepoParam(
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
          currentRepoParamProvider.overrideWithValue(
            repoDetailViewParameter,
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
          currentRepoParamProvider.overrideWithValue(
            repoDetailViewParameter,
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
          currentRepoParamProvider.overrideWithValue(
            RepoParam(
              ownerName: 'flutter',
              repoName: 'flutter',
              cache: _extra,
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
