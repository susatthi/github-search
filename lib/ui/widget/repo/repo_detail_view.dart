// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/ui/widget/common/async_value_handler.dart';
import 'package:github_search/ui/widget/repo/repo_detail_view_controller.dart';

/// リポジトリ詳細View
class RepoDetailView extends ConsumerWidget {
  const RepoDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  /// リポジトリID
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoDetailViewControllerProvider(id));
    return AsyncValueHandler<RepoData>(
      value: asyncValue,
      builder: (data) => _RepoDetailView(data: data),
    );
  }
}

class _RepoDetailView extends StatelessWidget {
  const _RepoDetailView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data.fullName),
    );
  }
}
