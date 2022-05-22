// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/common/avatar_preview_view.dart';

/// 画面遷移時に渡すパラメータのキー
const pageParamKeyAvatarPreviewUrl = 'avatar_preview_url';

/// アバターのプレビュー画面
class AvatarPreviewPage extends StatelessWidget {
  const AvatarPreviewPage({super.key});

  static const name = 'avatar-preview';
  static const path = '/avatar-preview/:$pageParamKeyAvatarPreviewUrl';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透過して遷移元画面が見えるようにする
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      body: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: const AvatarPreviewView(),
      ),
    );
  }
}
