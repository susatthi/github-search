// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/ui/widget/common/async_value_handler.dart';
import 'package:github_search/ui/widget/repo_list_view_controller.dart';

/// リポジトリ一覧View
class RepoListView extends ConsumerWidget {
  const RepoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoListViewControllerProvider);
    return AsyncValueHandler<List<RepoData>>(
      value: asyncValue,
      builder: (data) => _RepoListView(repos: data),
    );
  }
}

class _RepoListView extends StatelessWidget {
  const _RepoListView({
    Key? key,
    required this.repos,
  }) : super(key: key);

  final List<RepoData> repos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return ListTile(
          title: Text(repo.fullName),
        );
      },
    );
  }
}
