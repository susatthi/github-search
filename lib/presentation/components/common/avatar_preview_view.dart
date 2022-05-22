// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

/// プレビューするアバター画像のURL
final avatarPreviewUrlProvider = Provider.autoDispose<String>(
  (ref) => throw StateError('Provider was not initialized'),
);

/// アバターのプレビューView
class AvatarPreviewView extends ConsumerWidget {
  const AvatarPreviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(avatarPreviewUrlProvider);
    return PhotoView(
      imageProvider: CachedNetworkImageProvider(url),
      backgroundDecoration: const BoxDecoration(),
    );
  }
}
