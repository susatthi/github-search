// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/components/search_app_bar.dart';
import 'components/search_text_field.dart';
import 'components/sort_button.dart';

/// リポジトリ検索画面
class RepoSearchPage extends StatelessWidget {
  const RepoSearchPage({super.key});

  static const name = 'repo-search';
  static const path = 'search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const RepoSearchTextField(),
            actions: const [
              RepoSortButton(),
            ],
            backgroundColor: Theme.of(context).colorScheme.background,
            pinned: true,
          ),
        ],
      ),
    );
  }
}
