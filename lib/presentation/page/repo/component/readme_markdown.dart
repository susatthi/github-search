// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart';

import '../../../../domain/repository/repo/entity/repo.dart';
import '../../../../domain/repository/repo/repo_repository.dart';
import '../../../../domain/state/url_launcher.dart';
import '../../../../util/assets/assets.gen.dart';
import '../../../../util/logger.dart';
import '../../../component/async_value_handler.dart';

/// ReadmeMarkdownのキャッシュマネージャープロバイダー
final readmeMarkdownCacheManagerProvider = Provider<BaseCacheManager?>(
  (ref) => null,
);

/// READMEのMarkdown表示
class ReadmeMarkdown extends ConsumerWidget {
  const ReadmeMarkdown({
    super.key,
    required this.repo,
  });

  /// 現在のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueHandler<String>(
      value: ref.watch(readmeProviderFamily(repo)),
      builder: (content) => ReadmeMarkdownInternal(
        content: content,
      ),
      loading: () => const _LoadingIndicator(),
    );
  }
}

@visibleForTesting
class ReadmeMarkdownInternal extends ConsumerWidget {
  const ReadmeMarkdownInternal({
    super.key,
    required this.content,
  });

  /// Markdown　文字列
  final String content;

  /// CacheManager
  CacheManager get _defaultCacheManager => CacheManager(
        Config(
          'ReadmeMarkdownKey',
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 200,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheManager = ref.watch(readmeMarkdownCacheManagerProvider);
    return MarkdownBody(
      data: content,
      selectable: true,
      onTapLink: (_, href, __) async {
        logger.i('Tapped link: href = $href');
        if (href != null) {
          await ref.read(urlLauncherStateProvider.notifier).launch(href);
        }
      },
      extensionSet: ExtensionSet(
        ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          EmojiSyntax(),
          ...ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
      // CachedNetworkImage は SVG をサポートしていないため SVG が表示されない
      // 対策として、まずは画像として取得してみて、だめだったらSVGとして取得し直している
      // 参考サイト: https://github.com/Baseflow/flutter_cached_network_image/issues/383
      imageBuilder: (uri, _, __) => CachedNetworkImage(
        imageUrl: uri.toString(),
        cacheManager: cacheManager ?? _defaultCacheManager,
        errorWidget: (_, url, dynamic __) => SvgPicture.network(url),
      ),
    );
  }
}

/// ローディングインジケーター
class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Lottie.asset(Assets.lottie.loadingIndicator),
          ),
        ],
      ),
    );
  }
}
