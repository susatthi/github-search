// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/entities/repo/repo.dart';
import 'package:github_search/entities/repo/repo_data.dart';
import 'package:github_search/presentation/components/repo/repo_readme_content.dart';
import 'package:github_search/repositories/github/http_client.dart';

import '../../../test_utils/mocks.dart';
import '../../../test_utils/utils.dart';

void main() {
  late RepoData repo;
  setUp(() {
    repo = RepoData.from(
      Repo.fromJson(
        TestAssets.readJsonMap('github/get_repo_flutter_flutter.json')!,
      ),
    );
  });

  group('repoReadmeContentProvider', () {
    test('正常にREADMEコンテンツが取得できるはず', () async {
      final notifier = mockProviderContainer()
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
      final notifier = mockProviderContainer(
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