// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launch_data.freezed.dart';

/// URL起動データ
@freezed
class UrlLaunchData with _$UrlLaunchData {
  const factory UrlLaunchData({
    required String urlString,
    required LaunchMode mode,
  }) = _UrlLaunchData;

  const UrlLaunchData._();
}
