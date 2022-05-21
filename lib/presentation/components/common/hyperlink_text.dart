// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// ハイパーリンク表示するテキスト
class HyperlinkText extends StatelessWidget {
  const HyperlinkText({
    super.key,
    required this.text,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  /// 表示するテキスト
  final String text;

  /// パディング
  final EdgeInsetsGeometry padding;

  /// テキストタップ時のイベント
  final VoidCallback? onTap;

  /// アンカー表示時のテキストカラー
  static const anchorColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: padding,
      child: Text(text),
    );

    if (onTap == null) {
      return child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            color: anchorColor,
          ),
          child: child,
        ),
      ),
    );
  }
}
