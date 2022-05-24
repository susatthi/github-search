// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/localizations/strings.g.dart';

const defaultLocale = 'en';
const locale = String.fromEnvironment('locale', defaultValue: defaultLocale);

/// dart-define で与えられた言語情報を設定する
void useEnvironmentLocale() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.setLocaleRaw(locale);
}
