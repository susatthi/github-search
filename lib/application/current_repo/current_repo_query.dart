// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/repo/entity/repo.dart';
import '../../domain/repository/repo/entity/repo_param.dart';
import '../../domain/repository/repo/repo_repository.dart';

/// 現在のリポジトリプロバイダー
final currentRepoParamProvider = Provider<RepoParam>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// 現在のリポジトリプロバイダー
final currentRepoProvider = FutureProvider.autoDispose<Repo>(
  (ref) async {
    final param = ref.watch(currentRepoParamProvider);
    return ref.watch(repoProviderFamily(param).future);
  },
  dependencies: [
    currentRepoParamProvider,
    repoProviderFamily,
  ],
  name: 'currentRepoProvider',
);
