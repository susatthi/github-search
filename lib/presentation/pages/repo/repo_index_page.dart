// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../localizations/strings.g.dart';
import '../../widgets/repo/repo_list_view.dart';
import '../../widgets/repo/repo_order_toggle_button.dart';
import '../../widgets/repo/repo_search_text_field.dart';
import '../../widgets/repo/repo_sort_selector_dialog.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatelessWidget {
  const RepoIndexPage({Key? key}) : super(key: key);

  static const name = 'repo_index';
  static const path = '/repo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.appName),
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
      body: Column(
        children: const [
          RepoSearchTextField(),
          Expanded(
            child: RepoListView(),
          ),
        ],
      ),
    );
  }
}
