// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'values/repo_count.dart';
import 'values/repo_language.dart';

part 'repo.freezed.dart';

/// リポジトリEntity
@freezed
class Repo with _$Repo {
  const factory Repo({
    /// オーナー名
    required String ownerName,

    /// アバターURL
    required String avatarUrl,

    /// オーナーURL
    required String? ownerUrl,

    /// リポジトリ名
    required String repoName,

    /// リポジトリ名（フル）
    required String fullName,

    /// 説明
    String? description,

    /// スター数
    required RepoCount stargazersCount,

    /// ウォッチャー数
    required RepoCount watchersCount,

    /// プロジェクト言語
    required RepoLanguage language,

    /// フォーク数
    required RepoCount forksCount,

    /// Issue数
    required RepoCount openIssuesCount,

    /// デフォルトブランチ
    required String defaultBranch,

    /// リポジトリURL
    String? repoUrl,

    /// スター数URL
    String? stargazersUrl,

    /// ウォッチャー数URL
    String? watchersUrl,

    /// フォーク数URL
    String? forksUrl,

    /// Issue数URL
    String? issuesUrl,
  }) = _Repo;

  // ignore: unused_element
  const Repo._();

  @override
  String toString() {
    return 'Repo($fullName)';
  }
}
