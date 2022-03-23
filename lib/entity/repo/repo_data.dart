// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo.dart';

/// UI用リポジトリEntity
class RepoData {
  const RepoData({
    required this.name,
    required this.fullName,
  });

  factory RepoData.from(Repo repo) {
    return RepoData(
      name: repo.name,
      fullName: repo.fullName,
    );
  }

  /// リポジトリ名
  final String name;

  /// リポジトリ名（フル）
  final String fullName;
}
