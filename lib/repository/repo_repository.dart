// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/entity/repo/repo.dart';
import 'package:github_search/repository/http_repo_repository.dart';

final repoRepositoryProvider = Provider<RepoRepository>(
  (ref) {
    return const HttpRepoRepository();
  },
);

/// リポジトリRepository
abstract class RepoRepository {
  /// リポジトリを検索する
  Future<List<Repo>> searchRepos({
    required String query,
  });
}
