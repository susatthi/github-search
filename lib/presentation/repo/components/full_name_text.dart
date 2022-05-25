// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/selected_repo.dart';

/// リポジトリ名を表示するText
class RepoFullNameText extends ConsumerWidget {
  const RepoFullNameText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoSelectedRepoProvider);
    return asyncValue.when(
      data: (repo) => Text(repo.fullName),
      error: (_, __) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
