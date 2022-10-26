// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/url_launcher/entity/url_launch_data.dart';
import '../repository/url_launcher/url_launcher_repository.dart';

/// URL起動状態プロバイダー
final urlLauncherStateProvider = StateNotifierProvider<
    UrlLauncherStateController, AsyncValue<UrlLaunchData>>(
  (ref) => UrlLauncherStateController(
    urlLauncherRepository: ref.watch(urlLauncherRepositoryProvider),
  ),
);

/// URL起動状態コントローラー
class UrlLauncherStateController
    extends StateNotifier<AsyncValue<UrlLaunchData>> {
  UrlLauncherStateController({
    required this.urlLauncherRepository,
  }) : super(const AsyncValue.loading());

  final UrlLauncherRepository urlLauncherRepository;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    UrlLaunchMode mode = UrlLaunchMode.platformDefault,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final data = UrlLaunchData(urlString: urlString, mode: mode);
      await urlLauncherRepository.launch(data);
      return data;
    });
  }
}
