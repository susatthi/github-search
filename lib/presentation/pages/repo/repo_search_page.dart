// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../components/search_app_bar.dart';
import 'components/query_histories_list_view.dart';
import 'components/repo_sort_button.dart';
import 'components/search_repos_text_field.dart';

/// リポジトリ検索画面
class RepoSearchPage extends StatelessWidget {
  const RepoSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const SearchReposTextField(),
            actions: const [
              RepoSortButton(),
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
