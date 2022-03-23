// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo_response.dart';

/// UI用リポジトリEntity
class Repo {
  const Repo({
    required this.name,
    required this.fullName,
  });

  factory Repo.from(RepoResponse response) {
    return Repo(
      name: response.name,
      fullName: response.fullName,
    );
  }

  /// リポジトリ名
  final String name;

  /// リポジトリ名（フル）
  final String fullName;
}
