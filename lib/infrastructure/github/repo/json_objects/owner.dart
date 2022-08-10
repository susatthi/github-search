// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

/// オーナーJsonObject
@freezed
class OwnerJsonObject with _$OwnerJsonObject {
  const factory OwnerJsonObject({
    @JsonKey(name: 'login') required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    String? ownerUrl,
  }) = _OwnerJsonObject;

  factory OwnerJsonObject.fromJson(Map<String, dynamic> json) =>
      _$OwnerJsonObjectFromJson(json);
}
