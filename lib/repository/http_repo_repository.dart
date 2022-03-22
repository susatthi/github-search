// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo.dart';
import 'package:github_search/repository/repo_repository.dart';

/// HTTP通信用リポジトリRepository
class HttpRepoRepository implements RepoRepository {
  const HttpRepoRepository();

  @override
  Future<List<Repo>> searchRepos({required String query}) async {
    // TODO implements
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(100, (i) => i)
        .map((i) => Repo(name: 'サンプル$i', id: '$i'))
        .toList();
  }
}
