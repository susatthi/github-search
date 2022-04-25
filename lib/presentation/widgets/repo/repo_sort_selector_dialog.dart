// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localizations/strings.g.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_search_repos_sort.dart';

/// リポジトリ検索用ソート選択ダイアログ
class RepoSortSelectorDialog extends ConsumerWidget {
  const RepoSortSelectorDialog({Key? key}) : super(key: key);

  Map<String, RepoParamSearchReposSort> get _items => {
        i18n.bestMatch: RepoParamSearchReposSort.bestMatch,
        i18n.starsCount: RepoParamSearchReposSort.stars,
        i18n.forksCount: RepoParamSearchReposSort.forks,
        i18n.helpWantedIssuesCount: RepoParamSearchReposSort.helpWantedIssues,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(repoSearchReposSortProvider);
    return SimpleDialog(
      children: _items.entries
          .map(
            (e) => ListTile(
              leading: Visibility(
                visible: sort == e.value,
                child: const Icon(Icons.check),
              ),
              title: Text(e.key),
              onTap: () {
                logger.i('Changed ${e.value.name}');
                ref
                    .read(repoSearchReposSortProvider.notifier)
                    .update(sort: e.value);
                Navigator.of(context).pop();
              },
            ),
          )
          .toList(),
    );
  }
}
