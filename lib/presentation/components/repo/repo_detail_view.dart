// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/repo/repo_data.dart';
import '../common/cached_circle_avatar.dart';
import '../common/error_view.dart';
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
      data: (data) => _SliverRepoDetailView(data: data),
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

class _SliverRepoDetailView extends StatelessWidget {
  const _SliverRepoDetailView({
    required this.data,
  });

  final RepoData data;

  /// 1行のパディング
  static const _linePading = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  /// アイコンラベルのサイズ
  static const _iconLabelSize = 80.0;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CachedCircleAvatar(
                size: 100,
                url: data.owner.avatarUrl,
              ),
            ),
          ),
          Padding(
            padding: _linePading,
            child: Text(
              data.fullName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Visibility(
            visible: data.description?.isNotEmpty == true,
            child: Padding(
              padding: _linePading,
              child: Text(
                data.description ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Visibility(
            visible: data.language != null,
            child: Padding(
              padding: _linePading,
              child: RepoLanguageLabel(
                color: data.languageColor,
                language: data.language,
              ),
            ),
          ),
          Padding(
            padding: _linePading,
            child: Row(
              children: [
                SizedBox(
                  width: _iconLabelSize,
                  child: IconLabel(
                    icon: Icons.star_outline,
                    text: data.stargazersCountShort,
                  ),
                ),
                SizedBox(
                  width: _iconLabelSize,
                  child: IconLabel(
                    icon: Icons.visibility_outlined,
                    text: data.watchersCountShort,
                  ),
                ),
                SizedBox(
                  width: _iconLabelSize,
                  child: IconLabel(
                    icon: Icons.fork_right_outlined,
                    text: data.forksCountShort,
                  ),
                ),
                SizedBox(
                  width: _iconLabelSize,
                  child: IconLabel(
                    icon: Icons.bug_report_outlined,
                    text: data.openIssuesCountShort,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
