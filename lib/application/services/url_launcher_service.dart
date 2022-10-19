// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/logger.dart';
import '../../domain/entities/url_launcher.dart';

/// URL起動サービスプロバイダー
final urlLauncherServiceProvider = Provider.autoDispose(
  (ref) => UrlLauncherService(
    urlLauncherNotifier: ref.watch(urlLauncherStateProvider.notifier),
  ),
);

/// URL起動サービス
class UrlLauncherService {
  UrlLauncherService({
    required this.urlLauncherNotifier,
  });

  final StateController<UrlLauncherState> urlLauncherNotifier;

  /// URLを起動する
  Future<void> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    // 状態を起動前に更新する
    urlLauncherNotifier.update(
      (state) => UrlLauncherState(
        urlString: urlString,
        mode: mode,
      ),
    );

    try {
      final url = Uri.parse(urlString);
      final result = await launchUrl(url, mode: mode);
      if (result) {
        logger.i('Successful launch: url = $urlString');
      } else {
        logger.w('Failure launch: url = $urlString');
      }

      // 結果に応じて状態を更新する
      urlLauncherNotifier.update(
        (state) => state.copyWith(
          status: result ? UrlLauncherStatus.success : UrlLauncherStatus.error,
        ),
      );
    } on FormatException catch (e, s) {
      logger.e('Can\'t parse url: url = $urlString', e, s);
      urlLauncherNotifier.update(
        (state) => state.copyWith(
          status: UrlLauncherStatus.error,
          error: e,
        ),
      );
    } on PlatformException catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      urlLauncherNotifier.update(
        (state) => state.copyWith(
          status: UrlLauncherStatus.error,
          error: e,
        ),
      );
      // ignore: avoid_catching_errors
    } on ArgumentError catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      urlLauncherNotifier.update(
        (state) => state.copyWith(
          status: UrlLauncherStatus.error,
          error: e,
        ),
      );
    }
  }
}
