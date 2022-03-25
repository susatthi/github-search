// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/localizations/app_localizations.dart';

/// AppLocalizationsを使いやすくするクラス
class L10n {
  /// AppLocalizationsインスタンス取得の短縮版
  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      AppLocalizations.localizationsDelegates;

  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;
}
