// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/logger.dart';
import 'package:github_search/ui/widget/common/async_value_handler.dart';
import 'package:github_search/ui/widget/repo/repo_detail_view_controller.dart';

/// リポジトリ詳細View
class RepoDetailView extends ConsumerWidget {
  const RepoDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoDetailViewControllerProvider);
    return AsyncValueHandler<RepoData>(
      value: asyncValue,
      builder: (data) => _RepoDetailView(data: data),
    );
  }
}

class _RepoDetailView extends StatelessWidget {
  const _RepoDetailView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(data.owner.avatarUrl),
              onBackgroundImageError: (error, _) {
                logger.info(error);
              },
            ),
          ),
          ListTile(
            title: const Text('オーナー名'),
            trailing: Text(data.owner.name),
          ),
          ListTile(
            title: const Text('リポジトリ名'),
            trailing: Text(data.name),
          ),
          ListTile(
            title: const Text('プロジェクト言語'),
            trailing: Text(data.language ?? ''),
          ),
          ListTile(
            title: const Text('Star数'),
            trailing: Text('${data.stargazersCount}'),
          ),
          ListTile(
            title: const Text('Watcher数'),
            trailing: Text('${data.watchersCount}'),
          ),
          ListTile(
            title: const Text('Fork数'),
            trailing: Text('${data.forksCount}'),
          ),
          ListTile(
            title: const Text('Issue数'),
            trailing: Text('${data.openIssuesCount}'),
          ),
        ],
      ),
    );
  }
}
