// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/exceptions.dart';
import '../../domain/repositories/url_launcher/entities/url_launch_data.dart';
import '../../domain/repositories/url_launcher/url_launcher_repository.dart';
import '../../utils/logger.dart';

/// url_launcher 版URL起動Repositoryプロバイダー
final urlLauncherUrlLauncherRepositoryProvider =
    Provider<UrlLauncherRepository>(
  (ref) => const UrlLauncherUrlLauncherRepository(),
);

/// url_launcher 版URL起動Repository
class UrlLauncherUrlLauncherRepository implements UrlLauncherRepository {
  const UrlLauncherUrlLauncherRepository();

  @override
  Future<void> launch(UrlLaunchData data) async {
    final urlString = data.urlString;
    final mode = data.mode.toLaunchMode();
    try {
      final url = Uri.parse(urlString);
      final result = await launchUrl(url, mode: mode);
      if (!result) {
        logger.w('Failure launch: url = $urlString');
        throw UrlLauncherException(data);
      }
      logger.i('Successful launch: url = $urlString');
    } on FormatException catch (e, s) {
      logger.e('Can\'t parse url: url = $urlString', e, s);
      throw UrlLauncherException(data, e, s);
    } on PlatformException catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      throw UrlLauncherException(data, e, s);
      // ignore: avoid_catching_errors
    } on ArgumentError catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      throw UrlLauncherException(data, e, s);
    }
  }
}

extension _UrlLauncherModeEx on UrlLauncheMode {
  /// UrlLauncherMode => LaunchMode
  LaunchMode toLaunchMode() {
    switch (this) {
      case UrlLauncheMode.platformDefault:
        return LaunchMode.platformDefault;
      case UrlLauncheMode.inAppWebView:
        return LaunchMode.inAppWebView;
    }
  }
}
