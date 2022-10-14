// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../components/search_app_bar.dart';
import 'components/query_histories.dart';
import 'components/search_repos_query.dart';
import 'components/search_repos_sort.dart';

/// リポジトリ検索画面
class RepoSearchPage extends StatelessWidget {
  const RepoSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const SearchReposQueryTextField(),
            actions: const [
              SearchReposSortButton(),
            ],
            backgroundColor: Theme.of(context).colorScheme.background,
            pinned: true,
          ),
          const SliverQueryHistoriesListView(),
        ],
      ),
    );
  }
}
