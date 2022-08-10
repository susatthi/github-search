// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// CachedCircleAvatarのキャッシュマネージャープロバイダー
final cachedCircleAvatarCacheManagerProvider = Provider<BaseCacheManager?>(
  (ref) => null,
);

/// キャッシュするCircleAvatar
class CachedCircleAvatar extends ConsumerStatefulWidget {
  const CachedCircleAvatar({
    super.key,
    required this.url,
    this.size = 80,
    this.loading = true,
  });

  /// 画像のURL
  final String url;

  /// サイズ
  final double size;

  /// ローディングを表示するかどうか
  final bool loading;

  @override
  ConsumerState<CachedCircleAvatar> createState() => CachedCircleAvatarState();
}

@visibleForTesting
class CachedCircleAvatarState extends ConsumerState<CachedCircleAvatar> {
  final circleAvatarKey = GlobalKey(debugLabel: 'CircleAvatar');

  ImageProvider<Object>? get imageProvider => _imageProvider;
  ImageProvider<Object>? _imageProvider;

  dynamic get error => _error;
  dynamic _error;

  /// CacheManager
  CacheManager get _defaultCacheManager => CacheManager(
        Config(
          'CachedCircleAvatarKey',
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 20,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cacheManager = ref.watch(cachedCircleAvatarCacheManagerProvider);
    return CachedNetworkImage(
      cacheManager: cacheManager ?? _defaultCacheManager,
      height: widget.size,
      width: widget.size,
      imageUrl: widget.url,
      imageBuilder: (context, imageProvider) {
        _imageProvider = imageProvider;
        return CircleAvatar(
          key: circleAvatarKey,
          radius: widget.size / 2,
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
        );
      },
      placeholder: widget.loading
          ? (_, __) => Row(
                children: const [
                  Spacer(),
                  CircularProgressIndicator(),
                  Spacer(),
                ],
              )
          : null,
      errorWidget: (_, __, dynamic error) {
        _error = error;
        return Icon(
          Icons.error,
          size: widget.size,
        );
      },
    );
  }
}
