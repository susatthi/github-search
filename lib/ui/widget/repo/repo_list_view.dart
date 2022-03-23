// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/logger.dart';
import 'package:github_search/ui/page/repo/view_page.dart';
import 'package:github_search/ui/widget/common/async_value_handler.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_controller.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_state.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// リポジトリ一覧View
class RepoListView extends ConsumerWidget {
  const RepoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoListViewControllerProvider);
    return AsyncValueHandler<RepoListViewState>(
      value: asyncValue,
      builder: (state) => _RepoListView(state: state),
    );
  }
}

class _RepoListView extends StatelessWidget {
  const _RepoListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final RepoListViewState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.items.length + (state.hasNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < state.items.length) {
          final repo = state.items[index];
          return ListTile(
            title: Text(repo.fullName),
            onTap: () {
              context.goNamed(
                RepoViewPage.name,
                params: {
                  'id': '${repo.id}',
                },
              );
            },
          );
        }
        return const _CircularProgressListTile();
      },
    );
  }
}

/// リストビューを一番下までスクロールしたときに表示するプログレス
class _CircularProgressListTile extends ConsumerWidget {
  const _CircularProgressListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(repoListViewControllerProvider.notifier);
    return VisibilityDetector(
      key: const Key('for detect visibility'),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
      onVisibilityChanged: (info) async {
        if (info.visibleFraction > 0.1) {
          logger.info('appeared progress: info=$info');
          // 表示されたので次のページを取得する
          await controller.fetchNextPage();
        }
      },
    );
  }
}
