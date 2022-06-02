// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/repo/state/list_view_state.dart';

import '../../../test_utils/test_agent.dart';

void main() {
  final agent = TestAgent();
  late RepoListViewNotifier notifier;
  setUp(() async {
    await agent.setUp();
    notifier = agent
        .mockContainer()
        .listen(
          repoListViewStateProvider.notifier,
          (previous, next) {},
        )
        .read();
  });
  tearDown(agent.tearDown);

  group('RepoListViewNotifier', () {
    test('Notifierを生成するとリポジトリ検索結果エンティティを取得するはず', () async {
      // 初期値はAsyncLoading
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncLoading, true);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncData, true);
    });
    test('fetchNextPage()で次のページを取得するはず', () async {
      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      var state = notifier.state.value;
      expect(state, isNotNull);
      expect(state!.page, 1);
      expect(state.items.length, RepoListViewNotifier.perPage);
      expect(state.queryString, 'flutter');

      // 次のページを取得する
      await notifier.fetchNextPage();

      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      state = notifier.state.value;
      expect(state!.page, 2);
      expect(state.items.length, RepoListViewNotifier.perPage * 2);
      expect(state.queryString, 'flutter');
    });
    test('1ページ目を未取得の状態でfetchNextPage()を実行しても問題ないはず', () async {
      // 初期値はAsyncLoading
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncLoading, true);

      // 次のページを取得しようとする
      await notifier.fetchNextPage();

      // 状態は変化無しのはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      expect(notifier.state is AsyncLoading, true);

      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // データが取得できているはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      final state = notifier.state.value;
      expect(state, isNotNull);
      expect(state!.page, 1);
      expect(state.items.length, RepoListViewNotifier.perPage);
    });
    test('fetchNextPage()で次のページが無い場合は何もしないはず', () async {
      // データを取り終わるまで待つ
      await Future<void>.delayed(const Duration(microseconds: 500));

      // 2ページ目を取得する
      await notifier.fetchNextPage();

      // 3ページ目を取得する
      await notifier.fetchNextPage();

      // 3ページを取得した結果4ページ目は無いはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      var state = notifier.state.value;
      expect(state, isNotNull);
      expect(state!.page, 3);
      expect(state.items.length, RepoListViewNotifier.perPage * 2);

      // 4ページ目を取得する
      await notifier.fetchNextPage();

      // 4ページを取得しないはず
      // ignore: INVALID_USE_OF_PROTECTED_MEMBER
      state = notifier.state.value;
      expect(state, isNotNull);
      expect(state!.page, 3);
      expect(state.items.length, RepoListViewNotifier.perPage * 2);
    });
  });
}
