// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:markdown/markdown.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../utils/assets/assets.gen.dart';
import '../../../utils/logger.dart';
import '../../../utils/url_launcher.dart';
import 'repo_readme_content.dart';

/// リポジトリREADMEのMarkdown表示
class RepoReadmeMarkdown extends ConsumerWidget {
  const RepoReadmeMarkdown({super.key, required this.repo});

  /// 選択中のリポジトリデータ
  final RepoData repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoReadmeContentProviderFamily(repo));
    return asyncValue.when(
      data: (content) => RepoReadmeMarkdownInternal(content: content),
      error: (_, __) => const SizedBox(),
      loading: () => const _LoadingIndicator(),
    );
  }
}

@visibleForTesting
class RepoReadmeMarkdownInternal extends StatelessWidget {
  const RepoReadmeMarkdownInternal({
    super.key,
    required this.content,
  });

  /// Markdown　文字列
  final String content;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: content,
      selectable: true,
      onTapLink: (_, href, __) async {
        logger.i('Tapped link: href = $href');
        if (href != null) {
          await launchUrlInApp(href);
        }
      },
      extensionSet: ExtensionSet(
        ExtensionSet.gitHubFlavored.blockSyntaxes,
        [
          EmojiSyntax(),
          ...ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ],
      ),
      imageBuilder: (uri, _, __) {
        return CachedNetworkImage(imageUrl: uri.toString());
      },
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
