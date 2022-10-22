// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/url_launcher/entities/url_launch_data.dart';
import '../../domain/repositories/url_launcher/url_launcher_repository.dart';

/// URL起動コントローラープロバイダー
final urlLauncherControllerProvider = Provider<UrlLaunchController>(
  UrlLaunchController.new,
);

/// URL起動コントローラー
class UrlLaunchController {
  UrlLaunchController(this.ref);

  final Ref ref;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    UrlLauncheMode mode = UrlLauncheMode.platformDefault,
  }) async {
    await ref
        .read(urlLaunchDataProvider.notifier)
        .launch(urlString, mode: mode);
  }
}
