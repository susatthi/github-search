// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/current_repo/current_repo_query.dart';
import '../../../domain/repository/repo/entity/repo.dart';
import '../../component/async_value_handler.dart';
import '../../component/search_app_bar.dart';
import 'component/repo_detail_view.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const RepoViewTitle(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
          ),
          const SliverRepoDetailView(),
        ],
      ),
    );
  }
}

/// 現在のリポジトリ名を表示するText
@visibleForTesting
class RepoViewTitle extends ConsumerWidget {
  const RepoViewTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<Repo>(
      value: ref.watch(currentRepoProvider),
      builder: (repo) => Text(repo.fullName),
    );
  }
}
