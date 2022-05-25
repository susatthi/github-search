// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../localizations/strings.g.dart';
import '../components/error_view.dart';

/// エラー画面
class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.error,
  });

  /// 例外
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ErrorView(
          error: error ?? i18n.errorOccurred,
        ),
      ),
    );
  }
}
