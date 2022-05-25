// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/repo_search_repos_order.dart';
import '../../../localizations/strings.g.dart';
import '../../../utils/logger.dart';
import '../state/list_view_state.dart';
import 'search_repos_order.dart';

/// リポジトリ検索用オーダー値変更ボタン
class RepoOrderToggleButton extends ConsumerWidget {
  const RepoOrderToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // リポジトリ検索の実行中やエラー時はトグルボタンを無効化する
    final asyncValue = ref.watch(repoListViewStateProvider);
    return RepoOrderToggleButtonInternal(
      enabled: asyncValue?.when(
            data: (state) => true,
            error: (_, __) => false,
            loading: () => false,
          ) ??
          false,
    );
  }
}

@visibleForTesting
class RepoOrderToggleButtonInternal extends ConsumerWidget {
  const RepoOrderToggleButtonInternal({
    super.key,
    this.enabled = true,
  });

  /// 有効かどうか
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(repoSearchReposOrderProvider);
    logger.v('enabled=$enabled, order=${order.name}');
    return IconButton(
      onPressed: enabled
          ? () {
              final newOrder = order.toggle;
              logger.i('Chanced $newOrder');
              ref.read(repoSearchReposOrderProvider.notifier).order = newOrder;
            }
          : null,
      icon: Icon(
        order.icon,
        color: Theme.of(context).textTheme.titleSmall?.color,
      ),
      // ちらつきを防止するため無効化してても有効化と同じカラーにする
      disabledColor: Theme.of(context).textTheme.titleSmall?.color,
      tooltip: order.label,
    );
  }
}

extension _RepoParamSearchReposOrderHelper on RepoSearchReposOrder {
  /// トグルしたオーダー値を返す
  RepoSearchReposOrder get toggle {
    switch (this) {
      case RepoSearchReposOrder.desc:
        return RepoSearchReposOrder.asc;
      case RepoSearchReposOrder.asc:
        return RepoSearchReposOrder.desc;
    }
  }

  /// アイコンデータを返す
  IconData get icon {
    switch (this) {
      case RepoSearchReposOrder.desc:
        return Icons.arrow_downward;
      case RepoSearchReposOrder.asc:
        return Icons.arrow_upward;
    }
  }

  /// 表示名を返す
  String get label {
    switch (this) {
      case RepoSearchReposOrder.desc:
        return i18n.desc;
      case RepoSearchReposOrder.asc:
        return i18n.asc;
    }
  }
}
