// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../entities/repo/repo_data.dart';
import '../../../localizations/strings.g.dart';
import '../../../utils/assets/assets.gen.dart';
import '../../../utils/logger.dart';
import '../../pages/repo/repo_view_page.dart';
import '../common/cached_circle_avatar.dart';
import '../common/error_view.dart';
import '../common/list_loader.dart';
import 'repo_list_view_notifier.dart';
import 'repo_list_view_state.dart';

/// ListTileのleadingに表示するアバターのサイズ
const _avatarSize = 40.0;

/// Sliver版リポジトリ一覧View
class SliverRepoListView extends ConsumerWidget {
  const SliverRepoListView({
    super.key,
    this.controller,
  });

  /// ローディングを表示したら強制的にスクロール位置をトップに戻すために
  /// CustomScrollView の ScrollController をもらう
  final ScrollController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(repoListViewStateProvider);
    return asyncValue?.when(
          data: (state) => _SliverRepoListView(state: state),
          error: (e, s) => SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorView(
              error: e,
              stackTrace: s,
            ),
          ),
          loading: () {
            // スクロールの途中で再検索して戻ると若干スクロールした状態になってしまうので
            // ローディングを表示したときに強制的にスクロール位置をトップに戻す。
            if (controller?.hasClients == true) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => controller!.jumpTo(0),
              );
            }
            return const SliverFillRemaining(
              child: ListLoader(
                avatarSize: _avatarSize,
              ),
            );
          },
        ) ??
        const SliverFillRemaining();
  }
}

class _SliverRepoListView extends StatelessWidget {
  const _SliverRepoListView({
    super.key,
    required this.state,
  });

  final RepoListViewState state;

  @override
  Widget build(BuildContext context) {
    // 検索文字列が空の場合は検索を促す
    if (state.query.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: RepoPromptSearchView(),
      );
    }

    // 検索結果が0件の場合はリポジトリが見つからなかった旨を表示する
    if (state.items.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: RepoEmptyItemsView(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < state.items.length) {
            return Column(
              children: [
                _RepoListTile(
                  data: state.items[index],
                ),
                const Divider(),
              ],
            );
          }
          return const _LastIndicator();
        },
        childCount: state.items.length + (state.hasNext ? 1 : 0),
      ),
    );
  }
}

/// リポジトリListTile
class _RepoListTile extends StatelessWidget {
  const _RepoListTile({
    super.key,
    required this.data,
  });

  /// UI用リポジトリEntity
  final RepoData data;

  @override
  Widget build(BuildContext context) {
    final description = data.description;
    return ListTile(
      leading: CachedCircleAvatar(
        url: data.owner.avatarUrl,
        size: _avatarSize,
        loading: false,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.fullName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (description != null)
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
      subtitle: Row(
        children: [
          SizedBox(
            width: 80,
            child: _StargazersCountLabel(
              text: data.stargazersCountShort,
            ),
          ),
          const SizedBox(width: 10),
          _LanguageLabel(
            color: data.languageColor,
            language: data.language,
          ),
        ],
      ),
      onTap: () {
        // リポジトリ詳細画面に遷移する
        context.goNamed(
          RepoViewPage.name,
          params: RepoViewPage.params(
            ownerName: data.owner.name,
            repoName: data.name,
          ),
        );
      },
    );
  }
}

/// スター数のアイコン＋ラベル
class _StargazersCountLabel extends StatelessWidget {
  const _StargazersCountLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_outline,
          color: Theme.of(context).textTheme.caption!.color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(text),
        const Spacer(),
      ],
    );
  }
}

/// プロジェクト言語のカラー＋ラベル
class _LanguageLabel extends StatelessWidget {
  const _LanguageLabel({
    super.key,
    required this.color,
    this.language,
  });

  final Color color;
  final String? language;

  @override
  Widget build(BuildContext context) {
    if (language == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(language!),
      ],
    );
  }
}

/// リストビューを一番下までスクロールしたときに表示するインジケーター
class _LastIndicator extends ConsumerWidget {
  const _LastIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VisibilityDetector(
      key: const Key('for detect visibility'),
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Lottie.asset(Assets.lottie.loadingIndicator),
          ),
        ],
      ),
      onVisibilityChanged: (info) async {
        if (info.visibleFraction > 0.1) {
          logger.i('Appeared progress: info=$info');
          // 表示されたので次のページを取得する
          await ref.read(repoListViewStateProvider.notifier).fetchNextPage();
        }
      },
    );
  }
}

/// 検索前に表示する検索を促すView
@visibleForTesting
class RepoPromptSearchView extends StatelessWidget {
  const RepoPromptSearchView({super.key});

  static final _lottieFilePaths = <String>[
    Assets.lottie.githubDarkMode,
    Assets.lottie.githubLogo,
    Assets.lottie.octocat,
    Assets.lottie.coolOctovat,
    Assets.lottie.dashboardZippeo,
  ];

  /// Lottieファイルパスをランダムで返す
  String get lottieFilePath =>
      _lottieFilePaths[Random().nextInt(_lottieFilePaths.length)];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieFilePath,
            width: 200,
          ),
          const SizedBox(height: 24),
          Text(
            i18n.canSearchRepos,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

/// 検索結果が0件だった場合に表示するView
@visibleForTesting
class RepoEmptyItemsView extends StatelessWidget {
  const RepoEmptyItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.lottie.emptyState,
            width: 200,
          ),
          const SizedBox(height: 24),
          Text(
            i18n.notFoundRepos,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
