// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repository/app_data/app_data_repository.dart';
import '../../../../domain/repository/repo/entity/search_repos_sort.dart';
import '../../../../util/localization/strings.g.dart';
import '../../../../util/logger.dart';
import 'search_repos_order.dart';

/// リポジトリ検索用ソート選択ボトムシート
class SearchReposSortSelectorBottomSheet extends ConsumerWidget {
  const SearchReposSortSelectorBottomSheet({super.key});

  /// 選択項目のマップ
  Map<String, SearchReposSort> get _items => {
        i18n.bestMatch: SearchReposSort.bestMatch,
        i18n.starsCount: SearchReposSort.stars,
        i18n.forksCount: SearchReposSort.forks,
        i18n.helpWantedIssuesCount: SearchReposSort.helpWantedIssues,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(searchReposSortProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              i18n.sort,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: const SearchReposOrderToggleButton(),
          ),
          ..._items.entries.map(
            (e) => ListTile(
              leading: Visibility(
                visible: sort == e.value,
                child: const Icon(Icons.check),
              ),
              title: Text(e.key),
              onTap: () {
                logger.i('Changed: newSort = ${e.value.name}');
                ref.read(searchReposSortProvider.notifier).set(e.value);
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

/// リポジトリ検索用ソートボタン
class SearchReposSortButton extends StatelessWidget {
  const SearchReposSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) => const SearchReposSortSelectorBottomSheet(),
      ),
      icon: const Icon(Icons.sort),
      tooltip: i18n.sort,
    );
  }
}
