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

  final Color color;
  final String? language;

  @override
  Widget build(BuildContext context) {
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
