// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/ui/widget/repo/repo_list_view.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatelessWidget {
  const RepoIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubSearch'),
      ),
      body: const RepoListView(),
    );
  }
}
