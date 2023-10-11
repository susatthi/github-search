// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
    final child = ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 72,
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.bodySmall!.color,
              size: 20,
            ),
            const Gap(4),
            Text(text),
          ],
        ),
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
