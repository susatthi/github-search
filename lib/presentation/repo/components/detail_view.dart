// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/repo/entities/repo_data.dart';
import '../../../utils/logger.dart';
import '../../../utils/url_launcher.dart';
import '../../common/components/cached_circle_avatar.dart';
import '../../common/components/error_view.dart';
import '../../common/components/hyperlink_text.dart';
import '../../common/components/icon_label.dart';
import '../avatar_preview_page.dart';
import '../view_page.dart';
import 'language_label.dart';
import 'readme_markdown.dart';
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
    final asyncValue = ref.watch(repoSelectedRepoProvider);
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
  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          _AvatarRow(repo: repo),
          _FullnameRow(repo: repo),
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
  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () async {
            logger.i('Tapped avatar: url = ${repo.owner.avatarUrl}');

            // アバタープレビュー画面に遷移する
            context.goNamed(
              RepoAvatarPreviewPage.name,
              params: RepoViewPage.params(
                ownerName: repo.owner.name,
                repoName: repo.name,
              ),
              extra: repo,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(_verticalPadding),
            child: Hero(
              tag: 'avatar-${repo.fullName}',
              child: CachedCircleAvatar(
                size: 100,
                url: repo.owner.avatarUrl,
              ),
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
    required this.repo,
  });

  /// 選択中のリポジトリデータ
  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding / 2),
      child: DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.titleLarge,
        child: Wrap(
          children: [
            HyperlinkText(
              onTap: repo.owner.ownerUrl != null
                  ? () => launchUrlInApp(repo.owner.ownerUrl!)
                  : null,
              text: repo.owner.name,
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
              onTap: repo.repoUrl != null
                  ? () => launchUrlInApp(repo.repoUrl!)
                  : null,
              text: repo.name,
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
  final RepoData repo;

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
  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: repo.language != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        child: RepoLanguageLabel(
          color: repo.languageColor,
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
  final RepoData repo;

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
            text: repo.stargazersCountShort,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.watchersUrl,
            icon: Icons.visibility_outlined,
            text: repo.watchersCountShort,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.forksUrl,
            icon: Icons.fork_right_outlined,
            text: repo.forksCountShort,
          ),
          _IconLabel(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding / 2,
              vertical: _verticalPadding,
            ),
            url: repo.issuesUrl,
            icon: Icons.bug_report_outlined,
            text: repo.openIssuesCountShort,
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
  final RepoData repo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      child: RepoReadmeMarkdown(repo: repo),
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
