// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../localizations/strings.g.dart';
import '../../widgets/repo/repo_detail_view.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({Key? key}) : super(key: key);

  static const name = 'repo_view';
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
      appBar: AppBar(
        title: Text(i18n.repo),
      ),
      body: const RepoDetailView(),
    );
  }
}
