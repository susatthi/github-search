// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/ui/widget/repo/repo_detail_view.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({Key? key}) : super(key: key);

  /// repoView
  static const name = 'repoView';

  /// :id
  static const path = ':id';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リポジトリ'),
      ),
      body: const RepoDetailView(),
    );
  }
}
