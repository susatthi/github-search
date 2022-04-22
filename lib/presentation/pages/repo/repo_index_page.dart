// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/presentation/widgets/repo/repo_list_view.dart';
import 'package:github_search/presentation/widgets/repo/repo_search_text_field.dart';

import '../../../localizations/strings.g.dart';

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
