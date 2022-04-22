// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localizations/strings.g.dart';
import '../../../repositories/github/exception.dart';

/// AsyncValueのerrorとloadingをよしなに処理する
class AsyncValueHandler<T> extends StatelessWidget {
  const AsyncValueHandler({
    Key? key,
    required this.value,
    required this.builder,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T state) builder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: builder,
      error: (e, _) => Center(
        child: Text(_toString(context, e)),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// エラー文字列に変換する
  String _toString(BuildContext context, Object error) {
    if (error is GitHubException) {
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
    return error.toString();
  }
}
