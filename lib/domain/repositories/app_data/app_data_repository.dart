// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/entities/search_repos_order.dart';
import '../repo/entities/search_repos_sort.dart';
import 'entities/app_data_key.dart';

/// アプリデータRepositoryプロバイダー
final appDataRepositoryProvider = Provider<AppDataRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// リポジトリ検索用オーダー値プロバイダー
final searchReposOrderProvider =
    StateNotifierProvider<SearchReposOrderNotifier, SearchReposOrder>(
  (ref) => SearchReposOrderNotifier(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposOrderProvider',
);

/// リポジトリ検索用ソート値プロバイダー
final searchReposSortProvider =
    StateNotifierProvider<SearchReposSortNotifier, SearchReposSort>(
  (ref) => SearchReposSortNotifier(
    appDataRepository: ref.watch(appDataRepositoryProvider),
  ),
  name: 'searchReposSortProvider',
);

/// アプリデータRepository
abstract class AppDataRepository {
  /// 値を設定する
  void set<T extends Object?>(AppDataKey key, T value);

  /// 値を返す
  T get<T extends Object?>(AppDataKey key);

  /// Stream を返す
  Stream<T> changes<T extends Object?>(AppDataKey key);
}

/// アプリデータNotifier
abstract class AppDataNotifier<T> extends StateNotifier<T> {
  AppDataNotifier({
    required this.appDataRepository,
    required this.appDataKey,
  }) : super(
          appDataRepository.get<T>(appDataKey),
        ) {
    // Streamを監視して都度反映する
    appDataRepository.changes<T>(appDataKey).listen(
      (value) {
        state = value;
      },
    );
  }

  final AppDataRepository appDataRepository;
  final AppDataKey appDataKey;

  /// 設定する
  void set(T value) {
    appDataRepository.set<T>(appDataKey, value);
  }
}

/// リポジトリ検索用オーダー値Notifier
class SearchReposOrderNotifier extends AppDataNotifier<SearchReposOrder> {
  SearchReposOrderNotifier({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposOrder);
}

/// リポジトリ検索用ソート値Notifier
class SearchReposSortNotifier extends AppDataNotifier<SearchReposSort> {
  SearchReposSortNotifier({
    required super.appDataRepository,
  }) : super(appDataKey: AppDataKey.searchReposSort);
}
