// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'url_launch_data.freezed.dart';

/// URL起動モード
enum UrlLaunchMode {
  /// Leaves the decision of how to launch the URL to the platform
  /// implementation.
  platformDefault,

  /// Loads the URL in an in-app web view (e.g., Safari View Controller).
  inAppWebView,
}

/// URL起動データ
@freezed
class UrlLaunchData with _$UrlLaunchData {
  const factory UrlLaunchData({
    required String urlString,
    required UrlLaunchMode mode,
  }) = _UrlLaunchData;

  const UrlLaunchData._();
}
