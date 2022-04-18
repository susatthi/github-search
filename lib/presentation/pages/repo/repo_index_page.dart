// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/presentation/widgets/repo/repo_list_view.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_text_field.dart';
import 'package:github_search/utils/l10n.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatelessWidget {
  const RepoIndexPage({Key? key}) : super(key: key);

  static const name = 'repo_index';
  static const path = '/repo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).appName),
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
