// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/components/common/avatar_preview_view.dart';
import '../presentation/components/repo/repo_detail_view_notifier.dart';
import '../presentation/pages/common/avatar_preview_page.dart';
import '../presentation/pages/common/error_page.dart';
import '../presentation/pages/repo/repo_index_page.dart';
import '../presentation/pages/repo/repo_search_page.dart';
import '../presentation/pages/repo/repo_view_page.dart';

/// 画面遷移の定義Provider
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: RepoIndexPage.path,
    routes: [
      // リポジトリ一覧画面
      GoRoute(
        path: RepoIndexPage.path,
        name: RepoIndexPage.name,
        builder: (context, state) => const RepoIndexPage(),
        routes: [
          // リポジトリ検索画面
          GoRoute(
            path: RepoSearchPage.path,
            name: RepoSearchPage.name,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const RepoSearchPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          // リポジトリ詳細画面
          GoRoute(
            path: RepoViewPage.path,
            name: RepoViewPage.name,
            builder: (context, state) => ProviderScope(
              overrides: [
                repoDetailViewStateProvider.overrideWithProvider(
                  repoDetailViewStateProviderFamily(
                    RepoDetailViewParameter.from(state),
                  ),
                ),
              ],
              child: const RepoViewPage(),
            ),
          ),
        ],
      ),
      // アバタープレビュー画面
      GoRoute(
        path: AvatarPreviewPage.path,
        name: AvatarPreviewPage.name,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          opaque: false,
          child: ProviderScope(
            overrides: [
              avatarPreviewUrlProvider.overrideWithValue(
                state.params[pageParamKeyAvatarPreviewUrl]!,
              ),
            ],
            child: const AvatarPreviewPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
    // エラー画面
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
    observers: [pageRouteObserver],
    debugLogDiagnostics: !kReleaseMode,
  ),
);

/// ルートオブザーバー
///
/// 画面のpush/popのイベント検知に使用する。ダイアログは検知したく
/// ないのでModalRouteではなくPageRouteにしている
final pageRouteObserver = RouteObserver<PageRoute<void>>();
