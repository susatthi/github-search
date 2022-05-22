// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../utils/logger.dart';
import '../../../utils/url_launcher.dart';
import '../common/cached_circle_avatar.dart';
import '../common/error_view.dart';
import '../common/hyperlink_text.dart';
import '../common/icon_label.dart';
import '../common/preview_avatar_view.dart';
import 'repo_detail_view_notifier.dart';
import 'repo_language_label.dart';

/// 1行の縦方向のパディング
const _verticalPadding = 8.0;

/// 1行の横方向のパディング
const _horizontalPadding = 16.0;

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

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AvatarRow(data: data),
          _FullnameRow(data: data),
          _DescriptionRow(data: data),
          _LanguageRow(data: data),
          _CountRow(data: data),
        ],
      ),
    );
  }
}

/// アバター画像
class _AvatarRow extends StatelessWidget {
  const _AvatarRow({
    required this.data,
  });

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () async {
            logger.i('Tapped avatar');
            await showDialog<void>(
              context: context,
              builder: (context) => PreviewAvatarView(
                url: data.owner.avatarUrl,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(_verticalPadding),
            child: CachedCircleAvatar(
              size: 100,
              url: data.owner.avatarUrl,
            ),
          ),
        ),
      ),
    );
  }
}

/// リポジトリのフルネーム
class _FullnameRow extends StatelessWidget {
  const _FullnameRow({
    required this.data,
  });

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding / 2),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.titleLarge,
        child: Row(
          children: [
            HyperlinkText(
              onTap: data.owner.ownerUrl != null
                  ? () => launchUrlInApp(data.owner.ownerUrl!)
                  : null,
              text: data.owner.name,
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding / 2,
                vertical: _verticalPadding,
              ),
            ),
            const Text('/'),
            HyperlinkText(
              onTap: data.repoUrl != null
                  ? () => launchUrlInApp(data.repoUrl!)
                  : null,
              text: data.name,
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding / 2,
                vertical: _verticalPadding,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 説明
class _DescriptionRow extends StatelessWidget {
  const _DescriptionRow({
    required this.data,
  });

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Visibility(
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
    );
  }
}

/// プロジェクト言語
class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.data,
  });

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Visibility(
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
    );
  }
}

/// 各数値
class _CountRow extends StatelessWidget {
  const _CountRow({
    required this.data,
  });

  final RepoData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding / 2),
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
  final String? url;
  final IconData icon;
  final String text;

  /// アイコンラベルの幅
  static const _iconLabelWidth = 80.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _iconLabelWidth,
      child: IconLabel(
        icon: icon,
        text: text,
        padding: padding,
        onTap: url != null ? () => launchUrlInApp(url!) : null,
      ),
    );
  }
}
