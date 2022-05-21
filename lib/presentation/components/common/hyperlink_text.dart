// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// ハイパーリンク表示するテキスト
class HyperlinkText extends StatelessWidget {
  const HyperlinkText({
    super.key,
    required this.text,
    this.onTap,
  });

  /// 表示するテキスト
  final String text;

  /// テキストタップ時のイベント
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return Text(text);
    }

    // もともとの style に対してカラーだけ変える
    final effectiveTextStyle = DefaultTextStyle.of(context).style.merge(
          const TextStyle(
            color: Colors.blueAccent,
          ),
        );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: effectiveTextStyle,
        ),
      ),
    );
  }
}
