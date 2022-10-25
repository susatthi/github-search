// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../components/cached_circle_avatar.dart';

/// アバター画像プレビューView
class AvatarPreviewView extends ConsumerWidget {
  const AvatarPreviewView({
    super.key,
    required this.repo,
  });

  final Repo repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheManager = ref.watch(cachedCircleAvatarCacheManagerProvider);
    return Hero(
      tag: 'avatar-${repo.fullName}',
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(
          repo.avatarUrl,
          cacheManager: cacheManager,
        ),
        maxScale: 1.0,
        backgroundDecoration: const BoxDecoration(),
      ),
    );
  }
}
