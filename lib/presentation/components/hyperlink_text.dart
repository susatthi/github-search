// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'launch_url_state.dart';

/// ハイパーリンク表示するテキスト
class HyperlinkText extends ConsumerWidget {
  const HyperlinkText({
    super.key,
    required this.text,
    this.url,
    this.padding = EdgeInsets.zero,
  });

  /// 表示するテキスト
  final String text;

  /// URL
  final String? url;

  /// パディング
  final EdgeInsetsGeometry padding;

  /// アンカー表示時のテキストカラー
  static const anchorColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = Padding(
      padding: padding,
      child: Text(text),
    );

    // URLが無ければアンカー表示しない
    if (url == null) {
      return child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => ref.read(launcher)(url!),
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
