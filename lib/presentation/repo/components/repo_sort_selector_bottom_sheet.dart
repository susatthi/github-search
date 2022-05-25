// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repo/repositories/repo_repository.dart';
import '../../../localizations/strings.g.dart';
import '../../../utils/logger.dart';
import 'repo_order_toggle_button.dart';
import 'repo_search_repos_sort.dart';

/// リポジトリ検索用ソート選択ボトムシート
class RepoSortSelectorBottomSheet extends ConsumerWidget {
  const RepoSortSelectorBottomSheet({super.key});

  /// 選択項目のマップ
  Map<String, RepoSearchReposSort> get _items => {
        i18n.bestMatch: RepoSearchReposSort.bestMatch,
        i18n.starsCount: RepoSearchReposSort.stars,
        i18n.forksCount: RepoSearchReposSort.forks,
        i18n.helpWantedIssuesCount: RepoSearchReposSort.helpWantedIssues,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(repoSearchReposSortProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              i18n.sort,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: const RepoOrderToggleButton(),
          ),
          ..._items.entries
              .map(
                (e) => ListTile(
                  leading: Visibility(
                    visible: sort == e.value,
                    child: const Icon(Icons.check),
                  ),
                  title: Text(e.key),
                  onTap: () {
                    logger.i('Changed ${e.value.name}');
                    ref.read(repoSearchReposSortProvider.notifier).sort =
                        e.value;
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
