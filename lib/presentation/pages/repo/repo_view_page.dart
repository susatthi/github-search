// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../widgets/search_app_bar.dart';
import 'components/repo_detail_view.dart';
import 'components/repo_full_name_text.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({super.key});

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
