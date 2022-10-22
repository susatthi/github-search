// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: one_member_abstracts, comment_references

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entities/url_launch_data.dart';

/// URL起動Repositoryプロバイダー
final urlLauncherRepositoryProvider = Provider<UrlLauncherRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// URLの起動結果
final launchResultProvider = StateProvider<AsyncValue<UrlLaunchData>>(
  (_) => const AsyncValue.loading(),
);

/// URLを起動する
final launchProvider = Provider(
  (ref) => (UrlLaunchData data) async {
    final notifier = ref.read(launchResultProvider.notifier);
    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final repository = ref.watch(urlLauncherRepositoryProvider);
      await repository.launch(data);
      return data;
    });
  },
);

/// URL起動Repository
abstract class UrlLauncherRepository {
  /// URLを起動する
  ///
  /// URLが起動できない場合は [UrlLauncherException] を投げる。
  Future<void> launch(UrlLaunchData data);
}
