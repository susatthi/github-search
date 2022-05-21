// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logger.dart';

/// URLをアプリ内ブラウザで開く
///
/// エラーが起きたらログ出力して処理を終了する
Future<void> launchUrlInApp(String urlString) async {
  try {
    final url = Uri.parse(urlString);
    try {
      if (await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      )) {
        logger.i('Launch in app web view: url = $url');
      } else {
        logger.w('Can not launch in app web view: url = $url');
      }
    } on PlatformException catch (e, s) {
      logger.w('Can not launch in app web view: url = $url', e, s);
    }
  } on FormatException catch (e, s) {
    logger.e('Can not parse url: urlString = $urlString', e, s);
  }
}
