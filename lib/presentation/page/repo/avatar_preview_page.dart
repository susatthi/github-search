// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repository/repo/entity/repo.dart';
import '../../../domain/state/current_repo.dart';
import '../../../util/logger.dart';
import '../../component/async_value_handler.dart';
import 'component/avatar_preview_view.dart';

/// アバターのプレビュー画面
class AvatarPreviewPage extends StatelessWidget {
  const AvatarPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透過して遷移元画面が見えるようにする
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<Repo>(
      value: ref.watch(currentRepoProvider),
      builder: (repo) => InkWell(
        onTap: () {
          logger.v('Called onTap');
          context.pop();
        },
        child: AvatarPreviewView(repo: repo),
      ),
    );
  }
}
