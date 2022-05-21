// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../utils/url_launcher.dart';
import '../common/cached_circle_avatar.dart';
import '../common/error_view.dart';
import '../common/hyperlink_text.dart';
import '../common/icon_label.dart';
import 'repo_detail_view_notifier.dart';
import 'repo_language_label.dart';

/// Sliver版リポジトリ詳細View
class SliverRepoDetailView extends ConsumerWidget {
  const SliverRepoDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoDetailViewStateProvider);
    return asyncValue.when(
      data: (data) => SliverRepoDetailViewInternal(data: data),
      error: (e, s) => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorView(
          error: e,
          stackTrace: s,
        ),
      ),
      // 取得時間は短いと思うのでローディング表示はしない
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: SizedBox(),
      ),
    );
  }
}

@visibleForTesting
class SliverRepoDetailViewInternal extends StatelessWidget {
  const SliverRepoDetailViewInternal({
    super.key,
    required this.data,
  });

  final RepoData data;

  /// 1行の縦方向のパディング
  static const _verticalPadding = 8.0;

  /// 1行の横方向のパディング
  static const _horizontalPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(_verticalPadding),
              child: CachedCircleAvatar(
                size: 100,
                url: data.owner.avatarUrl,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
              vertical: _verticalPadding,
            ),
            child: DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.titleLarge,
              child: Row(
                children: [
                  HyperlinkText(
                    onTap: () => launchUrlInApp(data.owner.ownerUrl),
                    text: data.owner.name,
                  ),
                  const Text(' / '),
                  HyperlinkText(
                    onTap: () => launchUrlInApp(data.repoUrl),
                    text: data.name,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: data.description?.isNotEmpty == true,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
                vertical: _verticalPadding,
              ),
              child: Text(
                data.description ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Visibility(
            visible: data.language != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding,
                vertical: _verticalPadding,
              ),
              child: RepoLanguageLabel(
                color: data.languageColor,
                language: data.language,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: _horizontalPadding / 2),
            child: Row(
              children: [
                _IconLabel(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding / 2,
                    vertical: _verticalPadding,
                  ),
                  url: data.stargazersUrl,
                  icon: Icons.star_outline,
                  text: data.stargazersCountShort,
                ),
                _IconLabel(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding / 2,
                    vertical: _verticalPadding,
                  ),
                  url: data.watchersUrl,
                  icon: Icons.visibility_outlined,
                  text: data.watchersCountShort,
                ),
                _IconLabel(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding / 2,
                    vertical: _verticalPadding,
                  ),
                  url: data.forksUrl,
                  icon: Icons.fork_right_outlined,
                  text: data.forksCountShort,
                ),
                _IconLabel(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding / 2,
                    vertical: _verticalPadding,
                  ),
                  url: data.issuesUrl,
                  icon: Icons.bug_report_outlined,
                  text: data.openIssuesCountShort,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// アイコン＋ラベル
///
/// タップするとURLをアプリ内ブラウザで開く
class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.padding,
    required this.url,
    required this.icon,
    required this.text,
  });

  final EdgeInsetsGeometry padding;
  final String url;
  final IconData icon;
  final String text;

  /// アイコンラベルの幅
  static const _iconLabelWidth = 64.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => launchUrlInApp(url),
        child: Padding(
          padding: padding,
          child: SizedBox(
            width: _iconLabelWidth,
            child: IconLabel(
              icon: icon,
              text: text,
            ),
          ),
        ),
      ),
    );
  }
}
