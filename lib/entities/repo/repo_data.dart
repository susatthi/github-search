// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entities/owner/owner_data.dart';
import 'package:github_search/entities/repo/repo.dart';

/// UI用リポジトリEntity
class RepoData {
  const RepoData({
    required this.name,
    required this.fullName,
    required this.owner,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.forksCount,
    required this.openIssuesCount,
  });

  factory RepoData.from(Repo repo) {
    return RepoData(
      name: repo.name,
      fullName: repo.fullName,
      owner: OwnerData.from(repo.owner),
      stargazersCount: repo.stargazersCount,
      watchersCount: repo.watchersCount,
      language: repo.language,
      forksCount: repo.forksCount,
      openIssuesCount: repo.openIssuesCount,
    );
  }

  /// リポジトリ名
  final String name;

  /// リポジトリ名（フル）
  final String fullName;

  /// オーナー
  final OwnerData owner;

  /// スター数
  final int stargazersCount;

  /// ウォッチャー数
  final int watchersCount;

  /// プロジェクト言語
  final String? language;

  /// フォーク数
  final int forksCount;

  /// Issue数
  final int openIssuesCount;
}
