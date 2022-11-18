// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../../../domain/exceptions.dart';
import '../state/url_launch_data.dart';

/// ドメイン層で発生するURL起動例外
class UrlLauncherException extends DomainException {
  const UrlLauncherException(
    this.data, [
    this.details,
    this.stacktrace,
  ]) : super('UrlLauncher exception');

  /// URL起動データ
  final UrlLaunchData data;

  /// 例外
  final dynamic details;

  /// スタックトレース
  final StackTrace? stacktrace;

  @override
  String toString() => 'UrlLauncherException: $message, '
      '$data, details = $details';
}
