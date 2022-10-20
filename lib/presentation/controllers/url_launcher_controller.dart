// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/url_launcher.dart';

/// URL起動コントローラープロバイダー
final urlLauncherControllerProvider = Provider(
  (ref) => UrlLauncherController(
    notifier: ref.watch(urlLauncherProvider.notifier),
  ),
);

/// URL起動コントローラー
class UrlLauncherController {
  UrlLauncherController({
    required this.notifier,
  });

  final StateController<AsyncValue<UrlLauncher>> notifier;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      return UrlLauncher(
        urlString: urlString,
        mode: mode,
      ).launch();
    });
  }
}
