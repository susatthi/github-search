// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../controllers/selected_repo.dart';
import '../../../widgets/async_value_handler.dart';

/// リポジトリ名を表示するText
class RepoFullNameText extends ConsumerWidget {
  const RepoFullNameText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<Repo>(
      value: ref.watch(selectedRepoProvider),
      builder: (repo) => Text(repo.fullName),
    );
  }
}
