// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/logger.dart';

part 'url_launcher.freezed.dart';

/// URL起動のステータス
enum UrlLauncherStatus {
  /// 起動前
  waiting,

  /// 起動できた
  success,

  /// 起動できなかった
  error,
  ;
}

/// URL起動状態
///
/// URL起動に成功したかどうかのステータスを持つ
@freezed
class UrlLauncherState with _$UrlLauncherState {
  const factory UrlLauncherState({
    String? urlString,
    @Default(LaunchMode.platformDefault) LaunchMode mode,
    @Default(UrlLauncherStatus.waiting) UrlLauncherStatus status,
  }) = _UrlLauncherState;
}

/// URL起動状態のプロバイダー
///
/// `ref.listen` することでURL起動状態を監視できる
final urlLauncherStateProvider = StateProvider<UrlLauncherState>(
  (ref) => const UrlLauncherState(),
  name: 'urlLauncherStateProvider',
);

/// URL起動モードプロバイダー
final launchModeProvider = Provider(
  (ref) => LaunchMode.inAppWebView,
);

/// URL起動メソッドプロバイダー
///
/// UI側でこのメソッドを使ってURL起動をする
final urlLauncher = Provider(
  (ref) {
    final read = ref.read;
    return (String urlString) async {
      final notifier = read(urlLauncherStateProvider.notifier);
      final mode = read(launchModeProvider);

      // 状態を起動前に更新する
      notifier.state = UrlLauncherState(
        urlString: urlString,
        mode: mode,
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
        notifier.update(
          (state) => state.copyWith(
            status:
                result ? UrlLauncherStatus.success : UrlLauncherStatus.error,
          ),
        );
      } on FormatException catch (e, s) {
        logger.e('Can\'t parse url: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: UrlLauncherStatus.error,
          ),
        );
      } on PlatformException catch (e, s) {
        logger.w('Failure launch: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: UrlLauncherStatus.error,
          ),
        );
        // ignore: avoid_catching_errors
      } on ArgumentError catch (e, s) {
        logger.w('Failure launch: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: UrlLauncherStatus.error,
          ),
        );
      }
    };
  },
);
