// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localizations/strings.g.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_list_view_controller.dart';
import 'repo_search_repos_order.dart';

/// リポジトリ検索用オーダートグルボタン
class RepoOrderToggleButton extends ConsumerWidget {
  const RepoOrderToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // リポジトリ検索の実行中やエラー時はトグルボタンを無効化する
    final asyncValue = ref.watch(repoListViewControllerProvider);
    return asyncValue.when(
      data: (state) => const RepoOrderToggleButtonInternal(),
      error: (_, __) => const RepoOrderToggleButtonInternal(
        enabled: false,
      ),
      loading: () => const RepoOrderToggleButtonInternal(
        enabled: false,
      ),
    );
  }
}

@visibleForTesting
class RepoOrderToggleButtonInternal extends ConsumerWidget {
  const RepoOrderToggleButtonInternal({
    Key? key,
    this.enabled = true,
  }) : super(key: key);

  /// 有効かどうか
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(repoSearchReposOrderProvider);
    logger.d('enabled=$enabled, order=${order.name}');
    return IconButton(
      onPressed: enabled
          ? () {
              final newOrder = order.toggle;
              logger.i('Chanced $newOrder');
              ref.read(repoSearchReposOrderProvider.notifier).order = newOrder;
            }
          : null,
      icon: Icon(order.icon),
      // ちらつきを防止するため無効化してても有効化と同じカラーにする
      disabledColor: IconTheme.of(context).color,
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

  /// アイコンデータ
  static final icons = <RepoSearchReposOrder, IconData>{
    RepoSearchReposOrder.desc: Icons.arrow_downward,
    RepoSearchReposOrder.asc: Icons.arrow_upward,
  };

  /// アイコンデータを返す
  IconData get icon => icons[this]!;

  /// 表示名
  static final labels = <RepoSearchReposOrder, String>{
    RepoSearchReposOrder.desc: i18n.desc,
    RepoSearchReposOrder.asc: i18n.asc,
  };

  /// 表示名を返す
  String get label => labels[this]!;
}
