// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// キャッシュするCircleAvatar
class CachedCircleAvatar extends StatelessWidget {
  const CachedCircleAvatar({
    Key? key,
    required this.url,
    this.size = 80,
    this.loading = true,
  }) : super(key: key);

  /// 画像のURL
  final String url;

  /// サイズ
  final double size;

  /// ローディングを表示するかどうか
  final bool loading;

  /// CacheManager
  CacheManager get cacheManager => CacheManager(
        Config(
          'CachedCircleAvatarKey',
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 20,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: cacheManager,
      height: size,
      width: size,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.transparent,
        backgroundImage: imageProvider,
      ),
      placeholder: (_, __) => Visibility(
        visible: loading,
        child: Row(
          children: const [
            Spacer(),
            CircularProgressIndicator(),
            Spacer(),
          ],
        ),
      ),
      errorWidget: (_, __, dynamic ___) => Icon(
        Icons.error,
        size: size,
      ),
    );
  }
}
