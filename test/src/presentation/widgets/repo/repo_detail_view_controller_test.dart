// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/config/app.dart';
import 'package:github_search/src/config/constants.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view_controller.dart';

import '../../../../mocks/mocks.dart';

class _TestWidget extends ConsumerWidget {
  const _TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var errorType = 'success';
    try {
      ref.watch(repoDetailViewControllerProvider);
    } on ProviderException catch (e) {
      final ee = (e.exception as ProviderException).exception;
      errorType = ee.runtimeType.toString();
    }
    return Text(errorType);
  }
}

void main() {
  group('Provider', () {
    testWidgets('repoDetailViewControllerProviderは最初はStateErrorをthrowするはず',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: GithubSearchApp(
            home: const _TestWidget(),
          ),
        ),
      );
      expect(find.text('StateError'), findsOneWidget);
    });
    testWidgets('overridesすればStateErrorをthrowしないはず', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repoDetailViewControllerProvider.overrideWithProvider(
              repoDetailViewControllerProviderFamily({
                kPageParamKeyOwnerName: 'flutter',
                kPageParamKeyRepoName: 'flutter',
              }),
            ),
          ],
          child: GithubSearchApp(
            home: const _TestWidget(),
          ),
        ),
      );
      expect(find.text('success'), findsOneWidget);
    });
  });
  group('RepoDetailViewController', () {
    test('Controllerを生成するとリポジトリエンティティを取得するはず', () async {
      final controller = RepoDetailViewController(
        mockGithubRepoRepository,
        repoName: 'flutter',
        ownerName: 'flutter',
      );
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
