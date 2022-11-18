// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/logger.dart';
import 'exception/url_launcher_exception.dart';
import 'state/url_launch_data.dart';
import 'state/url_launch_result.dart';

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
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final notifier = ref.read(urlLaunchResultProvider.notifier);
    notifier.state = const AsyncValue.loading();
    notifier.state = await AsyncValue.guard(() async {
      final data = UrlLaunchData(urlString: urlString, mode: mode);
      try {
        final url = Uri.parse(urlString);
        final result = await launchUrl(url, mode: mode);
        if (!result) {
          logger.w('Failure launch: url = $urlString');
          throw UrlLauncherException(data);
        }
        logger.i('Successful launch: url = $urlString');
        return data;
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
    });
  }
}
