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

/// URL起動Repository
abstract class UrlLauncherRepository {
  /// URLを起動する
  ///
  /// URLが起動できない場合は [UrlLauncherException] を投げる。
  Future<void> launch(UrlLaunchData data);
}

/// URL起動プロバイダー
final urlLauncherProvider =
    StateNotifierProvider<UrlLauncherNotifier, AsyncValue<UrlLaunchData>>(
  (ref) => UrlLauncherNotifier(
    urlLauncherRepository: ref.watch(urlLauncherRepositoryProvider),
  ),
);

/// URL起動Notifier
class UrlLauncherNotifier extends StateNotifier<AsyncValue<UrlLaunchData>> {
  UrlLauncherNotifier({
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
      await urlLauncherRepository.launch(data);
      return data;
    });
  }
}
