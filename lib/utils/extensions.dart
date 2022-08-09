// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:responsive_framework/responsive_framework.dart';

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

extension ResponsiveWrapperDataEx on ResponsiveWrapperData {
  /// Breakpoint の name を返す
  String? get name => isDesktop
      ? DESKTOP
      : isMobile
          ? MOBILE
          : isTablet
              ? TABLET
              : null;
}
