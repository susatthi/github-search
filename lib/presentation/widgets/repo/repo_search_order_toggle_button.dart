// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localizations/strings.g.dart';
import '../../../repositories/repo_repository.dart';
import '../../../utils/logger.dart';
import 'repo_list_view_controller.dart';

/// リポジトリ検索用オーダー
final searchReposOrderProvider = StateProvider<RepoParamSearchReposOrder>(
  (ref) => RepoParamSearchReposOrder.desc,
);

/// リポジトリ検索用オーダートグルボタン
class RepoSearchOrderToggleButton extends ConsumerWidget {
  const RepoSearchOrderToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // リポジトリ検索の実行中やエラー時はトグルボタンを無効化する
    final asyncValue = ref.watch(repoListViewControllerProvider);
    return asyncValue.when(
      data: (state) => const _ToggleButton(),
      error: (_, __) => const _ToggleButton(
        enabled: false,
      ),
      loading: () => const _ToggleButton(
        enabled: false,
      ),
    );
  }
}

class _ToggleButton extends ConsumerWidget {
  const _ToggleButton({Key? key, this.enabled = true}) : super(key: key);

  /// 有効かどうか
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(searchReposOrderProvider);
    logger.d('enabled=$enabled, order=${order.name}');
    return IconButton(
      onPressed: enabled
          ? () {
              final newOrder = order.toggle;
              logger.i('Chanced $newOrder');
              ref.read(searchReposOrderProvider.notifier).state = newOrder;
            }
          : null,
      icon: Icon(order.icon),
      // ちらつきを防止するため無効化してても有効化と同じカラーにする
      disabledColor: IconTheme.of(context).color,
      tooltip: order.label,
    );
  }
}

extension _RepoParamSearchReposOrderHelper on RepoParamSearchReposOrder {
  /// トグルしたオーダー値を返す
  RepoParamSearchReposOrder get toggle {
    switch (this) {
      case RepoParamSearchReposOrder.desc:
        return RepoParamSearchReposOrder.asc;
      case RepoParamSearchReposOrder.asc:
        return RepoParamSearchReposOrder.desc;
    }
  }

  /// アイコンデータ
  static final icons = <RepoParamSearchReposOrder, IconData>{
    RepoParamSearchReposOrder.desc: Icons.arrow_downward,
    RepoParamSearchReposOrder.asc: Icons.arrow_upward,
  };

  /// アイコンデータを返す
  IconData get icon => icons[this]!;

  /// 表示名
  static final labels = <RepoParamSearchReposOrder, String>{
    RepoParamSearchReposOrder.desc: i18n.desc,
    RepoParamSearchReposOrder.asc: i18n.asc,
  };

  /// 表示名を返す
  String get label => labels[this]!;
}
