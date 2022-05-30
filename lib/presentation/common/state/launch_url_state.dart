// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/logger.dart';

part 'launch_url_state.freezed.dart';

/// URL起動のステータス
enum LaunchUrlStatus {
  /// 起動前
  wating,

  /// 起動できた
  success,

  /// 起動できなかった
  error;
}

/// URL起動状態
///
/// URL起動に成功したかどうかのステータスを持つ
@freezed
class LaunchUrlState with _$LaunchUrlState {
  const factory LaunchUrlState({
    String? urlString,
    @Default(LaunchMode.platformDefault) LaunchMode mode,
    @Default(LaunchUrlStatus.wating) LaunchUrlStatus status,
  }) = _LaunchUrlState;
}

/// URL起動状態のプロバイダー
///
/// `ref.listen` することでURL起動状態を監視できる
final launchUrlStateProvider = StateProvider<LaunchUrlState>(
  (ref) => const LaunchUrlState(),
);

/// URL起動モードプロバイダー
final launchModeProvider = Provider(
  (ref) => LaunchMode.inAppWebView,
);

/// URL起動メソッドプロバイダー
///
/// UI側でこのメソッドを使ってURL起動をする
final launcherProvider = Provider(
  (ref) {
    final notifier = ref.read(launchUrlStateProvider.notifier);
    final mode = ref.read(launchModeProvider);
    return (String urlString) async {
      // 状態を起動前に更新する
      notifier.state = LaunchUrlState(
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
            status: result ? LaunchUrlStatus.success : LaunchUrlStatus.error,
          ),
        );
      } on FormatException catch (e, s) {
        logger.e('Can\'t parse url: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: LaunchUrlStatus.error,
          ),
        );
      } on PlatformException catch (e, s) {
        logger.w('Failure launch: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: LaunchUrlStatus.error,
          ),
        );
        // ignore: avoid_catching_errors
      } on ArgumentError catch (e, s) {
        logger.w('Failure launch: url = $urlString', e, s);
        notifier.update(
          (state) => state.copyWith(
            status: LaunchUrlStatus.error,
          ),
        );
      }
    };
  },
);
