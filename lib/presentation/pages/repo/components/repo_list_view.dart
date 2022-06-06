// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:number_display/number_display.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../domain/repositories/repo/entities/repo.dart';
import '../../../../domain/repositories/repo/entities/values/repo_count.dart';
import '../../../../localizations/strings.g.dart';
import '../../../../utils/assets/assets.gen.dart';
import '../../../../utils/logger.dart';
import '../../../components/cached_circle_avatar.dart';
import '../../../components/error_view.dart';
import '../../../components/icon_label.dart';
import '../../../components/list_loader.dart';
import '../repo_view_page.dart';
import 'repo_language_label.dart';
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
    if (asyncValue.isRefreshing) {
      // スクロールの途中で再検索して戻ると若干スクロールした状態になってしまうので
      // ローディングを表示したときに強制的にスクロール位置をトップに戻す。
      if (controller?.hasClients == true) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => controller!.jumpTo(0),
        );
      }
    }

    return asyncValue.when(
      data: (state) {
        if (asyncValue.isRefreshing) {
          // リフレッシュ状態（前回のデータが残っている状態）でもローディング表示する
          return const SliverFillRemaining(
            child: ListLoader(
              avatarSize: _avatarSize,
            ),
          );
        }
        return SliverRepoListViewInternal(state: state);
      },
      error: (e, s) => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorView(
          error: e,
          stackTrace: s,
        ),
      ),
      loading: () => const SliverFillRemaining(
        child: ListLoader(
          avatarSize: _avatarSize,
        ),
      ),
    );
  }
}

@visibleForTesting
class SliverRepoListViewInternal extends StatelessWidget {
  const SliverRepoListViewInternal({
    super.key,
    required this.state,
  });

  final RepoListViewState state;

  @override
  Widget build(BuildContext context) {
    // 検索文字列が空の場合は検索を促す
    if (state.queryString.isEmpty) {
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

    // データの件数 + 検索結果表示 + 無限スクロール用のプログレス表示
    final childCount = state.items.length + 1 + (state.hasNext ? 1 : 0);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return _TotalCountListTile(
              totalCount: state.totalCount,
            );
          } else if (index < state.items.length + 1) {
            return _RepoListTile(
              repo: state.items[index - 1],
            );
          }
          return const _LastIndicator();
        },
        childCount: childCount,
      ),
    );
  }
}

/// 検索結果件数ListTile
class _TotalCountListTile extends StatelessWidget {
  const _TotalCountListTile({
    required this.totalCount,
  });

  /// 検索結果件数
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            i18n.totalCountResult(totalCount: createDisplay()(totalCount)),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

/// リポジトリListTile
class _RepoListTile extends StatelessWidget {
  const _RepoListTile({
    required this.repo,
  });

  /// リポジトリデータ
  final Repo repo;

  @override
  Widget build(BuildContext context) {
    final description = repo.description;
    return Column(
      children: [
        ListTile(
          leading: Hero(
            tag: 'avatar-${repo.fullName}',
            child: CachedCircleAvatar(
              url: repo.avatarUrl,
              size: _avatarSize,
              loading: false,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.fullName,
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
                child: IconLabel(
                  icon: Icons.star_outline,
                  text: repo.stargazersCount.display,
                ),
              ),
              RepoLanguageLabel(
                language: repo.language,
              ),
            ],
          ),
          onTap: () {
            // リポジトリ詳細画面に遷移する
            context.goNamed(
              RepoViewPage.name,
              params: RepoViewPage.params(
                ownerName: repo.ownerName,
                repoName: repo.repoName,
              ),
              extra: repo,
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}

/// リストビューを一番下までスクロールしたときに表示するインジケーター
class _LastIndicator extends ConsumerWidget {
  const _LastIndicator();

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
          logger.i('Appeared progress: info = $info');
          // 表示されたので次のページを取得する
          await ref.read(repoListViewStateProvider.notifier).fetchNextPage();
        }
      },
    );
  }
}

/// 検索前に表示する検索を促すView
@visibleForTesting
class RepoPromptSearchView extends StatefulWidget {
  const RepoPromptSearchView({super.key});

  @override
  State<RepoPromptSearchView> createState() => _RepoPromptSearchViewState();
}

class _RepoPromptSearchViewState extends State<RepoPromptSearchView> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    // 検索フィールドの×ボタン押下して検索文字列をクリアしてから検索画面に遷移するときに
    // 本Viewが表示されてちらついているように見えるため、500ミリ秒遅延させる
    Future<void>.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() => _opacity = 1));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 1000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottie.githubDarkMode,
              width: 200,
            ),
            Text(
              i18n.canSearchRepos,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
          ],
        ),
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
