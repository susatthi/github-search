// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

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

extension ListEx<E> on List<E> {
  /// RageErrorが起きないように自動で0<length内におさめる
  List<E> sublistSafety(int start, [int? end]) {
    if (isEmpty) {
      return this;
    }
    final effectiveStart = start < 0
        ? 0
        : start > length
            ? length
            : start;
    final effectiveEnd = end != null
        ? end < 0
            ? 0
            : end > length
                ? length
                : end
        : null;
    return sublist(effectiveStart, effectiveEnd);
  }
}
