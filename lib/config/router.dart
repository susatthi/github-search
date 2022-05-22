// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/components/repo/repo_detail_view_notifier.dart';
import '../presentation/pages/common/error_page.dart';
import '../presentation/pages/repo/repo_avatar_preview_page.dart';
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
        pageBuilder: (context, state) => DefaultTransitionPage(
          state: state,
          child: const RepoIndexPage(),
        ),
        routes: [
          // リポジトリ検索画面
          GoRoute(
            path: RepoSearchPage.path,
            name: RepoSearchPage.name,
            pageBuilder: (context, state) => DefaultTransitionPage(
              state: state,
              child: const RepoSearchPage(),
            ),
          ),
          // リポジトリ詳細画面
          GoRoute(
            path: RepoViewPage.path,
            name: RepoViewPage.name,
            pageBuilder: (context, state) => DefaultTransitionPage(
              state: state,
              child: ProviderScope(
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
            routes: [
              // アバタープレビュー画面
              GoRoute(
                path: RepoAvatarPreviewPage.path,
                name: RepoAvatarPreviewPage.name,
                pageBuilder: (context, state) => DefaultTransitionPage(
                  state: state,
                  opaque: false,
                  child: ProviderScope(
                    overrides: [
                      repoDetailViewStateProvider.overrideWithProvider(
                        repoDetailViewStateProviderFamily(
                          RepoDetailViewParameter.from(state),
                        ),
                      ),
                    ],
                    child: const RepoAvatarPreviewPage(),
                  ),
                ),
              ),
            ],
          ),
        ],
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

/// デフォルトのTransitionPage
class DefaultTransitionPage extends CustomTransitionPage<void> {
  DefaultTransitionPage({
    required GoRouterState state,
    required super.child,
    Widget Function(BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child)?
        transitionsBuilder,
    super.transitionDuration,
    super.maintainState,
    super.fullscreenDialog,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    LocalKey? key,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: transitionsBuilder ??
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
          key: key ?? state.pageKey,
        );
}
