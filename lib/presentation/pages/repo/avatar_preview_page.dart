// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/logger.dart';
import 'components/avatar_preview_view.dart';

/// アバターのプレビュー画面
class AvatarPreviewPage extends StatelessWidget {
  const AvatarPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透過して遷移元画面が見えるようにする
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      body: InkWell(
        onTap: () {
          logger.v('Called onTap');
          context.pop();
        },
        child: const AvatarPreviewView(),
      ),
    );
  }
}
