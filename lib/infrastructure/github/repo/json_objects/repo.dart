// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

import 'owner.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// リポジトリJsonObject
@freezed
class RepoJsonObject with _$RepoJsonObject {
  const factory RepoJsonObject({
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
    required OwnerJsonObject owner,
    required String? description,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'watchers_count') required int watchersCount,
    String? language,
    @JsonKey(name: 'forks_count') required int forksCount,
    @JsonKey(name: 'open_issues_count') required int openIssuesCount,
    @JsonKey(name: 'default_branch') required String defaultBranch,
    String? repoUrl,
    String? stargazersUrl,
    String? watchersUrl,
    String? forksUrl,
    String? issuesUrl,
  }) = _RepoJsonObject;

  factory RepoJsonObject.fromJson(Map<String, dynamic> json) =>
      _$RepoJsonObjectFromJson(json);
}
