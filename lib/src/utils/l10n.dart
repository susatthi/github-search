// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: avoid_classes_with_only_static_members
class L10n {
  /// AppLocalizationsインスタンス取得の短縮版
  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
