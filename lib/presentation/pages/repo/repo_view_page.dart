// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../components/search_app_bar.dart';
import 'components/repo_detail_view.dart';
import 'components/repo_full_name_text.dart';

/// 画面遷移時に渡すパラメータのキー
const pageParamKeyOwnerName = 'owner_name';
const pageParamKeyRepoName = 'repo_name';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({super.key});

  static const name = 'repo-view';
  static const path = ':$pageParamKeyOwnerName/:$pageParamKeyRepoName';

  /// 画面遷移用のパラメータを返す
  static Map<String, String> params({
    required String ownerName,
    required String repoName,
  }) =>
      {
        pageParamKeyOwnerName: ownerName,
        pageParamKeyRepoName: repoName,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const RepoFullNameText(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
          ),
          const SliverRepoDetailView(),
        ],
      ),
    );
  }
}
