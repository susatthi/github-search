// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/repo/avatar_preview_page.dart';
import '../presentation/pages/repo/components/selected_repo.dart';
import '../presentation/pages/repo/components/selected_repo_parameter.dart';
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
                  selectedRepoProvider.overrideWithProvider(
                    selectedRepoProviderFamily(
                      SelectedRepoParameter.from(state),
                    ),
                  ),
                ],
                child: const RepoViewPage(),
              ),
            ),
            routes: [
              // アバタープレビュー画面
              GoRoute(
                path: AvatarPreviewPage.path,
                name: AvatarPreviewPage.name,
                pageBuilder: (context, state) => DefaultTransitionPage(
                  state: state,
                  opaque: false,
                  child: ProviderScope(
                    overrides: [
                      selectedRepoProvider.overrideWithProvider(
                        selectedRepoProviderFamily(
                          SelectedRepoParameter.from(state),
                        ),
                      ),
                    ],
                    child: const AvatarPreviewPage(),
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

    // URLの#を除去する
    urlPathStrategy: UrlPathStrategy.path,
  ),
);

/// ルートオブザーバー
///
/// 画面のpush/popのイベント検知に使用する。ダイアログは検知したく
/// ないのでModalRouteではなくPageRouteにしている
final pageRouteObserver = PageRouteObserver();

/// RouteAware ではなくて PageRouteAware を扱える RouteObserver
///
/// RouteObserver とほぼ実装は同じ
class PageRouteObserver extends NavigatorObserver {
  final Map<PageRoute<void>, Set<PageRouteAware>> _listeners =
      <PageRoute<void>, Set<PageRouteAware>>{};

  @visibleForTesting
  bool debugObservingRoute(PageRoute<void> route) {
    late bool contained;
    assert(
      () {
        contained = _listeners.containsKey(route);
        return true;
      }(),
    );
    return contained;
  }

  void subscribe(PageRouteAware routeAware, PageRoute<void> route) {
    final subscribers = _listeners.putIfAbsent(route, () => <PageRouteAware>{});
    if (subscribers.add(routeAware)) {
      routeAware.didPush();
    }
  }

  void unsubscribe(PageRouteAware routeAware) {
    final routes = _listeners.keys.toList();
    for (final route in routes) {
      final subscribers = _listeners[route];
      if (subscribers != null) {
        subscribers.remove(routeAware);
        if (subscribers.isEmpty) {
          _listeners.remove(route);
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute<void> && previousRoute is PageRoute<void>) {
      final previousSubscribers = _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (final routeAware in previousSubscribers) {
          routeAware.didPopNext(route);
        }
      }

      final subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (final routeAware in subscribers) {
          routeAware.didPop(previousRoute);
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute<void> && previousRoute is PageRoute<void>) {
      final previousSubscribers = _listeners[previousRoute];

      if (previousSubscribers != null) {
        for (final routeAware in previousSubscribers) {
          routeAware.didPushNext(route);
        }
      }
    }
  }
}

/// RouteAware の I/F に遷移元/遷移先の Route を加えた I/F
abstract class PageRouteAware {
  void didPopNext(Route<dynamic> nextRoute) {}
  void didPush() {}
  void didPop(Route<dynamic> previousRoute) {}
  void didPushNext(Route<dynamic> nextRoute) {}
}

/// デフォルトのTransitionPage
class DefaultTransitionPage extends CustomTransitionPage<void> {
  DefaultTransitionPage({
    required GoRouterState state,
    required super.child,
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    )?
        transitionsBuilder,
    super.transitionDuration,
    super.maintainState,
    super.fullscreenDialog,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    LocalKey? key,
    String? name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: transitionsBuilder ?? _transitionsBuilder,
          key: key ?? state.pageKey,
          name: name ?? state.name,
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);
}
