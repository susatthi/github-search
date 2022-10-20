// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/logger.dart';
import '../exceptions.dart';

part 'url_launcher.freezed.dart';

/// URL起動
@freezed
class UrlLauncher with _$UrlLauncher {
  const factory UrlLauncher({
    required String urlString,
    required LaunchMode mode,
  }) = _UrlLauncher;

  const UrlLauncher._();

  /// URLを起動する
  ///
  /// URLが起動できない場合は [UrlLauncherException] を投げる。
  Future<UrlLauncher> launch() async {
    try {
      final url = Uri.parse(urlString);
      final result = await launchUrl(url, mode: mode);
      if (!result) {
        logger.w('Failure launch: url = $urlString');
        throw UrlLauncherException(this);
      }
      logger.i('Successful launch: url = $urlString');
      return this;
    } on FormatException catch (e, s) {
      logger.e('Can\'t parse url: url = $urlString', e, s);
      throw UrlLauncherException(this, e, s);
    } on PlatformException catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      throw UrlLauncherException(this, e, s);
      // ignore: avoid_catching_errors
    } on ArgumentError catch (e, s) {
      logger.w('Failure launch: url = $urlString', e, s);
      throw UrlLauncherException(this, e, s);
    }
  }
}
