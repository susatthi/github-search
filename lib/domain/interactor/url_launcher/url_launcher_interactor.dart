// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repositories/url_launcher/entities/url_launch_data.dart';
import '../../repositories/url_launcher/url_launcher_repository.dart';

/// URL起動インタラクタープロバイダー
final urlLauncherInteractorProvider = Provider(
  UrlLauncherInteractor.new,
  name: 'urlLauncherInteractorProvider',
);

/// URL起動インタラクター
class UrlLauncherInteractor {
  UrlLauncherInteractor(this.ref);

  final Ref ref;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    UrlLauncheMode mode = UrlLauncheMode.platformDefault,
  }) async {
    final notifier = ref.read(urlLaunchStateProvider.notifier);
    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final data = UrlLaunchData(urlString: urlString, mode: mode);
      final repository = ref.watch(urlLauncherRepositoryProvider);
      await repository.launch(data);
      return data;
    });
  }
}

/// URLの起動状態
final urlLaunchStateProvider = StateProvider<AsyncValue<UrlLaunchData>>(
  (_) => const AsyncValue.loading(),
);
