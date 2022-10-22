// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/url_launcher/entities/url_launch_data.dart';
import '../../domain/repositories/url_launcher/url_launcher_repository.dart';

/// URL起動プロバイダー
final urlLaunchProvider =
    StateNotifierProvider<UrlLauncherController, AsyncValue<UrlLaunchData>>(
  (ref) => UrlLauncherController(
    urlLauncherRepository: ref.watch(urlLauncherRepositoryProvider),
  ),
);

/// URL起動コントローラー
class UrlLauncherController extends StateNotifier<AsyncValue<UrlLaunchData>> {
  UrlLauncherController({
    required this.urlLauncherRepository,
  }) : super(const AsyncValue.loading());

  final UrlLauncherRepository urlLauncherRepository;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    UrlLauncheMode mode = UrlLauncheMode.platformDefault,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final data = UrlLaunchData(urlString: urlString, mode: mode);
      final repository = urlLauncherRepository;
      await repository.launch(data);
      return data;
    });
  }
}
