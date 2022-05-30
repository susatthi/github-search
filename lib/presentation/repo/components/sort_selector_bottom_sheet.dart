// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/search_repos_sort.dart';
import '../../../localizations/strings.g.dart';
import '../../../utils/logger.dart';
import '../state/search_repos_sort.dart';
import 'order_toggle_button.dart';

/// リポジトリ検索用ソート選択ボトムシート
class RepoSortSelectorBottomSheet extends ConsumerWidget {
  const RepoSortSelectorBottomSheet({super.key});

  /// 選択項目のマップ
  Map<String, SearchReposSort> get _items => {
        i18n.bestMatch: SearchReposSort.bestMatch,
        i18n.starsCount: SearchReposSort.stars,
        i18n.forksCount: SearchReposSort.forks,
        i18n.helpWantedIssuesCount: SearchReposSort.helpWantedIssues,
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
                    logger.i('Changed: newSort = ${e.value.name}');
                    ref.read(repoSearchReposSortUpdater)(e.value);
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
