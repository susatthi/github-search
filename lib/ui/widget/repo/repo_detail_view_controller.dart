// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo_data.dart';
import 'package:github_search/logger.dart';
import 'package:github_search/ui/widget/repo/repo_list_view_controller.dart';

final repoDetailViewControllerProvider = StateNotifierProvider.autoDispose<
    RepoDetailViewController, AsyncValue<RepoData>>(
  (ref) => throw StateError('Provider was not initialized'),
);

final repoDetailViewControllerProviderFamily = StateNotifierProvider.family
    .autoDispose<RepoDetailViewController, AsyncValue<RepoData>, String>(
  (ref, id) {
    final controller = ref.read(repoListViewControllerProvider.notifier);
    final repo = controller.findById(id);
    logger.info('create RepoDetailViewController: id=${repo?.id}');
    return RepoDetailViewController(
      data: repo,
    );
  },
);

class RepoDetailViewController extends StateNotifier<AsyncValue<RepoData>> {
  RepoDetailViewController({
    RepoData? data,
  }) : super(const AsyncValue.loading()) {
    if (data != null) {
      state = AsyncValue.data(data);
    } else {
      state = AsyncValue.error(Exception('empty data'));
    }
  }
}
