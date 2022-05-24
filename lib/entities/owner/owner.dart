// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

/// オーナーEntity
@freezed
class Owner with _$Owner {
  const factory Owner({
    @JsonKey(name: 'login') required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    String? ownerUrl,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
