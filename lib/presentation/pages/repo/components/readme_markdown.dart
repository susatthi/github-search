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

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/repo_repository.dart';
import '../../../../utils/assets/assets.gen.dart';
import '../../../../utils/logger.dart';
import '../../../components/launch_url_state.dart';

/// READMEコンテンツプロバイダー（Family）
final readmeContentProviderFamily = StateNotifierProvider.family
    .autoDispose<ReadmeContentNotifier, AsyncValue<String>, Repo>(
  (ref, repo) {
    logger.i(
      'Create ReadmeContentNotifier: fullName = ${repo.fullName}, '
      'defaultBranch = ${repo.defaultBranch}',
    );
    return ReadmeContentNotifier(
      ref.read,
      repo: repo,
    );
  },
);

/// READMEコンテンツNotifier
class ReadmeContentNotifier extends StateNotifier<AsyncValue<String>> {
  ReadmeContentNotifier(
    Reader read, {
    required this.repo,
  })  : _repoRepository = read(repoRepositoryProvider),
        super(const AsyncValue.loading()) {
    _get();
  }

  final RepoRepository _repoRepository;

  /// リポジトリEntity
  final Repo repo;

  Future<void> _get() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _repoRepository.getReadme(
        repo: repo,
      );
    });
  }
}

/// READMEのMarkdown表示
class ReadmeMarkdown extends ConsumerWidget {
  const ReadmeMarkdown({
    super.key,
    required this.repo,
    this.cacheManager,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  /// CacheManager
  final CacheManager? cacheManager;

  /// CacheManager
  CacheManager get _defaultCacheManager => CacheManager(
        Config(
          'ReadmeMarkdown',
          stalePeriod: const Duration(days: 1),
          maxNrOfCacheObjects: 200,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(readmeContentProviderFamily(repo));
    return asyncValue.when(
      data: (content) => ReadmeMarkdownInternal(
        content: content,
        cacheManager: cacheManager ?? _defaultCacheManager,
      ),
      error: (_, __) => const SizedBox(),
      loading: () => const _LoadingIndicator(),
    );
  }
}

@visibleForTesting
class ReadmeMarkdownInternal extends ConsumerWidget {
  const ReadmeMarkdownInternal({
    super.key,
    required this.content,
    required this.cacheManager,
  });

  /// Markdown　文字列
  final String content;

  /// CacheManager
  final CacheManager cacheManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MarkdownBody(
      data: content,
      selectable: true,
      onTapLink: (_, href, __) async {
        logger.i('Tapped link: href = $href');
        if (href != null) {
          await ref.read(launcher)(href);
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
        cacheManager: cacheManager,
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
