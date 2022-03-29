// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/utils/l10n.dart';

/// エラー画面
class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  /// 例外
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).error),
      ),
      body: Center(
        child: Text(error?.toString() ?? L10n.of(context).errorOccurred),
      ),
    );
  }
}
