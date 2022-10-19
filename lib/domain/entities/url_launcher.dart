// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'url_launcher.freezed.dart';

/// URL起動状態プロバイダー
///
/// `ref.listen` することでURL起動状態を監視できる
final urlLauncherStateProvider = StateProvider.autoDispose<UrlLauncherState>(
  (ref) => const UrlLauncherState(),
  name: 'urlLauncherStateProvider',
);

/// URL起動状態
///
/// URL起動に成功したかどうかのステータスを持つ
@freezed
class UrlLauncherState with _$UrlLauncherState {
  const factory UrlLauncherState({
    String? urlString,
    @Default(LaunchMode.platformDefault) LaunchMode mode,
    @Default(UrlLauncherStatus.waiting) UrlLauncherStatus status,
    dynamic error,
  }) = _UrlLauncherState;
}

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
