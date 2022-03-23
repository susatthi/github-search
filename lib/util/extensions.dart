// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

extension IterableEx<E> on Iterable<E> {
  // for Null Safety
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  // for Null Safety
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
