// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// アイコン＋ラベル
class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.icon,
    required this.text,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  final IconData icon;
  final String text;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: padding,
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).textTheme.caption!.color,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(text),
        ],
      ),
    );

    // タップイベントが無ければアンカー表示しない
    if (onTap == null) {
      return child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
