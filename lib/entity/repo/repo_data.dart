// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entity/repo/repo.dart';

/// UI用リポジトリEntity
class RepoData {
  const RepoData({
    required this.id,
    required this.name,
    required this.fullName,
  });

  factory RepoData.from(Repo repo) {
    return RepoData(
      id: repo.id,
      name: repo.name,
      fullName: repo.fullName,
    );
  }

  /// ID
  final int id;

  /// リポジトリ名
  final String name;

  /// リポジトリ名（フル）
  final String fullName;
}
