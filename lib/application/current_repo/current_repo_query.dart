// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/repo_param.dart';
import '../../domain/repository/repo/entity/repo.dart';
import '../../domain/repository/repo/repo_repository.dart';

/// 現在のリポジトリプロバイダー
final currentRepoProvider = FutureProvider.autoDispose<Repo?>(
  (ref) async {
    final param = ref.watch(currentRepoParamProvider);
    if (param == null) {
      return null;
    }

    final repo = param.extra;
    if (repo != null) {
      // extra があればそのまま使う
      return repo;
    }

    // extra が無いので取得する
    final repoRepository = ref.watch(repoRepositoryProvider);
    return repoRepository.getRepo(
      ownerName: param.ownerName,
      repoName: param.repoName,
    );
  },
  name: 'currentRepoProvider',
  dependencies: [
    currentRepoParamProvider,
    repoRepositoryProvider,
  ],
);
