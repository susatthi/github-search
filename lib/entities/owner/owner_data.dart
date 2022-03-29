// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:github_search/entities/owner/owner.dart';

/// UI用オーナーEntity
class OwnerData {
  const OwnerData({
    required this.name,
    required this.avatarUrl,
  });

  factory OwnerData.from(Owner owner) {
    return OwnerData(
      name: owner.login,
      avatarUrl: owner.avatarUrl,
    );
  }

  /// オーナー名
  final String name;

  /// アバターURL
  final String avatarUrl;
}
