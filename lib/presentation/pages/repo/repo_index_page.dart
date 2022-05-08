// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../localizations/strings.g.dart';
import '../../components/repo/repo_list_view.dart';
import '../../components/repo/repo_order_toggle_button.dart';
import '../../components/repo/repo_search_text_field.dart';
import '../../components/repo/repo_sort_selector_dialog.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatelessWidget {
  const RepoIndexPage({Key? key}) : super(key: key);

  static const name = 'repo_index';
  static const path = '/repo';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              titleSpacing: 8,
              title: const RepoSearchTextField(),
              actionsIconTheme: IconTheme.of(context),
              actions: [
                const RepoOrderToggleButton(),
                IconButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => const RepoSortSelectorDialog(),
                  ),
                  icon: const Icon(Icons.sort),
                  tooltip: i18n.sort,
                ),
              ],
            ),
            const SliverRepoListView(),
          ],
        ),
      ),
    );
  }
}
