// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../../../infrastructure/github/json_object/owner/owner.dart';

/// オーナーEntity
class Owner {
  const Owner({
    required this.name,
    required this.avatarUrl,
    required this.ownerUrl,
  });

  factory Owner.from(OwnerJsonObject owner) {
    return Owner(
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
