// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/url_launcher/entity/url_launch_data.dart';
import '../../domain/repository/url_launcher/url_launcher_repository.dart';

/// URL起動サービスプロバイダー
final urlLauncherServiceProvider = Provider(
  UrlLauncherService.new,
);

/// URL起動サービス
class UrlLauncherService {
  const UrlLauncherService(this.ref);

  final Ref ref;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    UrlLaunchMode mode = UrlLaunchMode.platformDefault,
  }) async {
    await ref
        .read(urlLauncherStateProvider.notifier)
        .launch(urlString, mode: mode);
  }
}
