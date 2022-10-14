// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/repositories/app_data/app_data_repository.dart';
import '../../../../domain/repositories/app_data/entities/app_data_key.dart';
import '../../../../domain/repositories/repo/entities/search_repos_order.dart';
import '../../../../utils/localizations/strings.g.dart';
import '../../../../utils/logger.dart';
import '../../../components/app_data.dart';
import 'search_repos.dart';

/// リポジトリ検索用オーダー値プロバイダー
final searchReposOrderProvider =
    StateNotifierProvider<SearchReposOrderController, SearchReposOrder>(
  (ref) => SearchReposOrderController(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposOrderProvider',
);

/// リポジトリ検索用オーダー値コントローラー
class SearchReposOrderController extends AppDataController<SearchReposOrder> {
  SearchReposOrderController({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposOrder);
}

/// リポジトリ検索用オーダー値変更ボタン
class SearchReposOrderToggleButton extends ConsumerWidget {
  const SearchReposOrderToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // リポジトリ検索の実行中やエラー時はトグルボタンを無効化する
    final asyncValue = ref.watch(searchReposStateProvider);
    return SearchReposOrderToggleButtonInternal(
      enabled: asyncValue.when(
        data: (state) => true,
        error: (_, __) => false,
        loading: () => false,
      ),
    );
  }
}

@visibleForTesting
class SearchReposOrderToggleButtonInternal extends ConsumerWidget {
  const SearchReposOrderToggleButtonInternal({
    super.key,
    this.enabled = true,
  });

  /// 有効かどうか
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(searchReposOrderProvider);
    logger.v('enabled = $enabled, order = ${order.name}');
    return IconButton(
      onPressed: enabled
          ? () {
              final newOrder = order.toggle;
              logger.i('Toggled: newOrder = $newOrder');
              ref.read(searchReposOrderProvider.notifier).update(newOrder);
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
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

extension _SearchReposOrderHelper on SearchReposOrder {
  /// トグルしたオーダー値を返す
  SearchReposOrder get toggle {
    switch (this) {
      case SearchReposOrder.desc:
        return SearchReposOrder.asc;
      case SearchReposOrder.asc:
        return SearchReposOrder.desc;
    }
  }

  /// アイコンデータを返す
  IconData get icon {
    switch (this) {
      case SearchReposOrder.desc:
        return Icons.arrow_downward;
      case SearchReposOrder.asc:
        return Icons.arrow_upward;
    }
  }

  /// 表示名を返す
  String get label {
    switch (this) {
      case SearchReposOrder.desc:
        return i18n.desc;
      case SearchReposOrder.asc:
        return i18n.asc;
    }
  }
}
