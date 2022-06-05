// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import 'selected_repo.dart';

/// アバター画像プレビューView
class RepoAvatarPreviewView extends ConsumerWidget {
  const RepoAvatarPreviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoSelectedRepoProvider);
    return asyncValue.when(
      data: (repo) => _RepoAvatarPreviewView(repo: repo),
      // ほぼ失敗しないしすぐに元に戻れるのでエラー表示はしない
      error: (_, __) => const SizedBox(),
      // 取得時間は短いと思うのでローディング表示はしない
      loading: () => const SizedBox(),
    );
  }
}

class _RepoAvatarPreviewView extends ConsumerWidget {
  const _RepoAvatarPreviewView({
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Hero(
      tag: 'avatar-${repo.fullName}',
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(repo.avatarUrl),
        backgroundDecoration: const BoxDecoration(),
      ),
    );
  }
}
