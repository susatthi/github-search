// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/src/l10n/l10n.dart';
import 'package:github_search/src/repositories/github/api_exception.dart';

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
    if (error is GithubApiException && error.code != null) {
      switch (error.code!) {
        case GithubApiExceptionCode.badRequest:
          return l10n.githubApiExceptionMessageBadRequest;
        case GithubApiExceptionCode.badCredentials:
          return l10n.githubApiExceptionMessageBadCredentials;
        case GithubApiExceptionCode.maximumNumberOfLoginAttemptsExceeded:
          return l10n
              .githubApiExceptionMessageMaximumNumberOfLoginAttemptsExceeded;
        case GithubApiExceptionCode.notFound:
          return l10n.githubApiExceptionMessageNotFound;
        case GithubApiExceptionCode.validationFailed:
          return l10n.githubApiExceptionMessageValidationFailed;
        case GithubApiExceptionCode.serviceUnavailable:
          return l10n.githubApiExceptionMessageServiceUnavailable;
        case GithubApiExceptionCode.unknown:
          return l10n.githubApiExceptionMessageUnknown;
        case GithubApiExceptionCode.noInternetConnection:
          return l10n.githubApiExceptionMessageNoInternetConnection;
      }
    } else {
      return error.toString();
    }
  }
}
