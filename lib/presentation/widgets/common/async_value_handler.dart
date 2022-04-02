// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/repositories/github/exception.dart';
import 'package:github_search/utils/l10n.dart';

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
    final l10n = L10n.of(context);
    if (error is GitHubException) {
      switch (error.code) {
        case GitHubException.codeBadRequest:
          return l10n.gitHubExceptionMessageBadRequest;
        case GitHubException.codeBadCredentials:
          return l10n.gitHubExceptionMessageBadCredentials;
        case GitHubException.codeMaximumNumberOfLoginAttemptsExceeded:
          return l10n
              .gitHubExceptionMessageMaximumNumberOfLoginAttemptsExceeded;
        case GitHubException.codeNotFound:
          return l10n.gitHubExceptionMessageNotFound;
        case GitHubException.codeValidationFailed:
          return l10n.gitHubExceptionMessageValidationFailed;
        case GitHubException.codeServiceUnavailable:
          return l10n.gitHubExceptionMessageServiceUnavailable;
        case GitHubException.codeUnknown:
          return l10n.gitHubExceptionMessageUnknown;
        case GitHubException.codeNoInternetConnection:
          return l10n.gitHubExceptionMessageNoInternetConnection;
      }
    }
    return error.toString();
  }
}
