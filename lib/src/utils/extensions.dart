// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension IterableEx<E> on Iterable<E> {
  /// for Null Safety [firstWhere]
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// for Null Safety [lastWhere]
  E? lastWhereOrNull(bool Function(E element) test) {
    late E result;
    var foundMatching = false;
    for (final element in this) {
      if (test(element)) {
        result = element;
        foundMatching = true;
      }
    }
    if (foundMatching) {
      return result;
    }
    return null;
  }
}

extension AppLocalizationsHelper on BuildContext {
  /// AppLocalizationsインスタンス取得の短縮版
  AppLocalizations locale() => AppLocalizations.of(this)!;
}
