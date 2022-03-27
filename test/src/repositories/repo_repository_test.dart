// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/src/config/app.dart';
import 'package:github_search/src/repositories/repo_repository.dart';

class _TestWidget extends ConsumerWidget {
  const _TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoRepository = ref.watch(repoRepositoryProvider);
    return Text(repoRepository.runtimeType.toString());
  }
}

void main() {
  group('Provider', () {
    testWidgets('repoRepositoryProviderからGithubRepoRepositoryが取得できるはず',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: GithubSearchApp(
            home: const _TestWidget(),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('GithubRepoRepository'), findsOneWidget);
    });
  });
}
