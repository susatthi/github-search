// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entities/repo/repo_data.dart';
import 'package:github_search/presentation/widgets/common/async_value_handler.dart';
import 'package:github_search/presentation/widgets/common/cached_circle_avatar.dart';
import 'package:github_search/presentation/widgets/repo/repo_detail_view_controller.dart';
import 'package:github_search/utils/l10n.dart';

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
            child: CachedCircleAvatar(
              url: data.owner.avatarUrl,
            ),
          ),
          ListTile(
            title: Text(L10n.of(context).ownerName),
            trailing: Text(data.owner.name),
          ),
          ListTile(
            title: Text(L10n.of(context).repoName),
            trailing: Text(data.name),
          ),
          ListTile(
            title: Text(L10n.of(context).projectLanguage),
            trailing: Text(data.language ?? ''),
          ),
          ListTile(
            title: Text(L10n.of(context).starsCount),
            trailing: Text('${data.stargazersCount}'),
          ),
          ListTile(
            title: Text(L10n.of(context).watchersCount),
            trailing: Text('${data.watchersCount}'),
          ),
          ListTile(
            title: Text(L10n.of(context).forksCount),
            trailing: Text('${data.forksCount}'),
          ),
          ListTile(
            title: Text(L10n.of(context).issuesCount),
            trailing: Text('${data.openIssuesCount}'),
          ),
        ],
      ),
    );
  }
}
