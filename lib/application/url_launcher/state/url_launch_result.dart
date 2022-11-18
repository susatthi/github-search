// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'url_launch_data.dart';

/// URL起動結果プロバイダー
final urlLaunchResultProvider = StateProvider<AsyncValue<UrlLaunchData?>>(
  (ref) => const AsyncValue.data(null),
);
