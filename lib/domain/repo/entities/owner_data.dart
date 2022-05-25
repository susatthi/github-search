// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../../../infrastructure/github/json_object/owner/owner.dart';

/// UI用オーナーEntity
class OwnerData {
  const OwnerData({
    required this.name,
    required this.avatarUrl,
    required this.ownerUrl,
  });

  factory OwnerData.from(Owner owner) {
    return OwnerData(
      name: owner.login,
      avatarUrl: owner.avatarUrl,
      ownerUrl: owner.ownerUrl,
    );
  }

  /// オーナー名
  final String name;

  /// アバターURL
  final String avatarUrl;

  /// オーナーURL
  final String? ownerUrl;
}
