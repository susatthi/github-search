// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// プロジェクト言語のカラー＋ラベル
class RepoLanguageLabel extends StatelessWidget {
  const RepoLanguageLabel({
    super.key,
    required this.color,
    this.language,
  });

  /// プロジェクト言語のカラー
  final Color color;

  /// プロジェクト言語名
  final String? language;

  @override
  Widget build(BuildContext context) {
    // プロジェクト言語名が null なら何も表示しない
    if (language == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(language!),
      ],
    );
  }
}
