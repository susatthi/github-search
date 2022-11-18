// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../domain/repository/repo/entity/value_object/repo_language.dart';

/// プロジェクト言語のカラー＋ラベル
class RepoLanguageLabel extends StatelessWidget {
  const RepoLanguageLabel({
    super.key,
    required this.language,
  });

  /// プロジェクト言語
  final RepoLanguage language;

  @override
  Widget build(BuildContext context) {
    // プロジェクト言語名が null なら何も表示しない
    if (language.value == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          Icons.circle,
          color: language.color,
          size: 20,
        ),
        const Gap(4),
        Text(language.display),
      ],
    );
  }
}
