// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/src/config/constants.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({Key? key}) : super(key: key);

  static const name = 'repo_view';
  static const path = ':$kPageParamKeyOwnerName/:$kPageParamKeyRepoName';

  /// 画面遷移用のパラメータを返す
  static Map<String, String> params({
    required String ownerName,
    required String repoName,
  }) =>
      {
        kPageParamKeyOwnerName: ownerName,
        kPageParamKeyRepoName: repoName,
      };

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
