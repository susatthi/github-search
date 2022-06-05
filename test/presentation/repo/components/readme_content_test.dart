// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/json_objects/repo.dart';
import 'package:github_search/infrastructure/github/repo_repository.dart';
import 'package:github_search/presentation/repo/components/readme_content.dart';

import '../../../test_utils/mocks.dart';
import '../../../test_utils/test_agent.dart';
import '../../../test_utils/utils.dart';

void main() {
  final repo = GitHubRepoRepository.repoBuilder(
    RepoJsonObject.fromJson(
      TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
    ),
  );

  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('repoReadmeContentProvider', () {
    test('正常にREADMEコンテンツが取得できるはず', () async {
      final notifier = agent
          .mockContainer()
          .listen(
            repoReadmeContentProviderFamily(repo).notifier,
            (previous, next) {},
          )
          .read();
      // 初期値はAsyncLoading
      expect(notifier.state is AsyncLoading, true);
      expect(notifier.state.value, isNull);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      expect(notifier.state is AsyncData, true);
      expect(notifier.state.value, isNotNull);
    });
    test('通信エラー時はAsyncErrorのはず', () async {
      final notifier = agent
          .mockContainer(
            overrides: [
              // 常にエラーを返すHTTPクライアントを使う
              httpClientProvider.overrideWithValue(mockHttpClientError),
            ],
          )
          .listen(
            repoReadmeContentProviderFamily(repo).notifier,
            (previous, next) {},
          )
          .read();

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // AsyncErrorのはず
      expect(notifier.state is AsyncError, true);
    });
  });
}
