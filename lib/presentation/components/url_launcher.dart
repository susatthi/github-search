// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/url_launcher.dart';

/// URL起動プロバイダー
///
/// `ref.listen` することでURL起動を監視できる
final urlLauncherProvider =
    StateNotifierProvider<UrlLauncherController, AsyncValue<UrlLauncher>>(
  (ref) => UrlLauncherController(),
  name: 'urlLauncherProvider',
);

/// URL起動コントローラー
class UrlLauncherController extends StateNotifier<AsyncValue<UrlLauncher>> {
  UrlLauncherController() : super(const AsyncValue.loading());

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return UrlLauncher(
        urlString: urlString,
        mode: mode,
      ).launch();
    });
  }
}
