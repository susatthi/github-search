// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/ui/widget/common/async_value_handler.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_controller.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_state.dart';

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
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final repo = state.items[index];
        return ListTile(
          title: Text(repo.fullName),
        );
      },
    );
  }
}
