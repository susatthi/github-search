// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import '../localizations/strings.g.dart';
import '../repositories/github/exception.dart';

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

extension ObjectEx on Object {
  /// エラーメッセージを返す
  String toErrorMessage() {
    if (this is GitHubException) {
      final error = this as GitHubException;
      switch (error.code) {
        case GitHubException.codeBadRequest:
          return i18n.gitHubExceptionMessage.badRequest;
        case GitHubException.codeBadCredentials:
          return i18n.gitHubExceptionMessage.badCredentials;
        case GitHubException.codeMaximumNumberOfLoginAttemptsExceeded:
          return i18n
              .gitHubExceptionMessage.maximumNumberOfLoginAttemptsExceeded;
        case GitHubException.codeNotFound:
          return i18n.gitHubExceptionMessage.notFound;
        case GitHubException.codeValidationFailed:
          return i18n.gitHubExceptionMessage.validationFailed;
        case GitHubException.codeServiceUnavailable:
          return i18n.gitHubExceptionMessage.serviceUnavailable;
        case GitHubException.codeUnknown:
          return i18n.gitHubExceptionMessage.unknown;
        case GitHubException.codeNoInternetConnection:
          return i18n.gitHubExceptionMessage.noInternetConnection;
      }
    }
    return toString();
  }
}
