// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/routing/router.dart';
import '../../../components/cached_circle_avatar.dart';
import '../../../components/error_view.dart';
import '../../../components/hyperlink_text.dart';
import '../../../components/icon_label.dart';
import '../../../components/states/url_launcher.dart';
import 'readme_markdown.dart';
import 'repo_language_label.dart';
import 'selected_repo.dart';

/// 1行の縦方向のパディング
const _verticalPadding = 8.0;

/// 1行の横方向のパディング
const _horizontalPadding = 16.0;

/// Sliver版リポジトリ詳細View
class SliverRepoDetailView extends ConsumerWidget {
  const SliverRepoDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(selectedRepoProvider);
    return asyncValue.when(
      data: (repo) => SliverRepoDetailViewInternal(repo: repo),
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
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          _AvatarRow(repo: repo),
          _FullNameRow(repo: repo),
          _DescriptionRow(repo: repo),
          _LanguageRow(repo: repo),
          _IconLabelsRow(repo: repo),
          const Divider(),
          _ReadmeRow(repo: repo),
        ],
      ),
    );
  }
}

/// アバター画像
class _AvatarRow extends StatelessWidget {
  const _AvatarRow({
    required this.repo,
  }) : super(key: const Key('repo_detail_view#_AvatarRow'));

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () async {
            logger.i('Tapped avatar: url = ${repo.avatarUrl}');

            // アバタープレビュー画面に遷移する
            AvatarPreviewRoute.from(repo).go(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(_verticalPadding),
            child: Hero(
              tag: 'avatar-${repo.fullName}',
              child: CachedCircleAvatar(
                size: 100,
                url: repo.avatarUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// リポジトリのフルネーム
class _FullNameRow extends StatelessWidget {
  const _FullNameRow({
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding / 2),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.titleLarge,
        child: Wrap(
          children: [
            HyperlinkText(
              text: repo.ownerName,
              url: repo.ownerUrl,
              padding: const EdgeInsets.symmetric(
                horizontal: _horizontalPadding / 2,
                vertical: _verticalPadding,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: _verticalPadding,
              ),
              child: Text('/'),
            ),
            HyperlinkText(
              text: repo.repoName,
              url: repo.repoUrl,
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
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: repo.description?.isNotEmpty == true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        child: Text(
          repo.description ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

/// プロジェクト言語
class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: repo.language.value != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        child: RepoLanguageLabel(
          language: repo.language,
        ),
      ),
    );
  }
}

/// アイコンラベル一式
class _IconLabelsRow extends StatelessWidget {
  const _IconLabelsRow({
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

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
            url: repo.stargazersUrl,
            icon: Icons.star_outline,
            text: repo.stargazersCount.display,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.watchersUrl,
            icon: Icons.visibility_outlined,
            text: repo.watchersCount.display,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.forksUrl,
            icon: Icons.fork_right_outlined,
            text: repo.forksCount.display,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.issuesUrl,
            icon: Icons.bug_report_outlined,
            text: repo.openIssuesCount.display,
          ),
        ],
      ),
    );
  }
}

/// README
class _ReadmeRow extends StatelessWidget {
  const _ReadmeRow({
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: ReadmeMarkdown(repo: repo),
    );
  }
}

/// アイコン＋ラベル
///
/// タップするとURLを開く
class _IconLabel extends ConsumerWidget {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconLabel(
      icon: icon,
      text: text,
      padding: padding,
      onTap: url != null
          ? () => ref.read(urlLauncherProvider.notifier).launch(url!)
          : null,
    );
  }
}
