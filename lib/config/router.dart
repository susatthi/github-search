// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../domain/repositories/repo/entities/repo.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/repo/avatar_preview_page.dart';
import '../presentation/pages/repo/components/selected_repo.dart';
import '../presentation/pages/repo/repo_index_page.dart';
import '../presentation/pages/repo/repo_search_page.dart';
import '../presentation/pages/repo/repo_view_page.dart';

part 'router.g.dart';

/// ルーティングテーブル
@TypedGoRoute<RepoIndexRoute>(
  path: '/repos',
  routes: [
    TypedGoRoute<RepoSearchRoute>(
      path: 'search',
    ),
    TypedGoRoute<RepoViewRoute>(
      path: ':ownerName/:repoName',
      routes: [
        TypedGoRoute<AvatarPreviewRoute>(
          path: 'avatar',
        ),
      ],
    ),
  ],
)

/// リポジトリ一覧画面
class RepoIndexRoute extends GoRouteData {
  const RepoIndexRoute();

  static const name = 'repo-index';

  @override
  Page<void> buildPage(BuildContext context) => TransitionPage.fade(
        name: name,
        child: const RepoIndexPage(),
      );
}

/// リポジトリ検索画面
class RepoSearchRoute extends GoRouteData {
  const RepoSearchRoute();

  static const name = 'repo-search';

  @override
  Page<void> buildPage(BuildContext context) => TransitionPage.fade(
        name: name,
        child: const RepoSearchPage(),
      );
}

/// リポジトリ詳細画面
///
/// 下記の go_router_builder のバグ？があるため、$extra でキャッシュされた Repo
/// を受け取るのをやめている。バグが直ったら元に戻したい。
///
/// ＜バグの内容＞
/// $extra を含むルートがネストしていて、ネストしたページを開いたときにエラーが発生する。
/// アバター画面表示時に $extra に AvatarPreviewRoute インスタンスがきて
/// 型不一致でエラーになってしまう。
///
/// ＜回避方法＞
/// $extra をやめること。
class RepoViewRoute extends GoRouteData {
  const RepoViewRoute(
    this.ownerName,
    this.repoName,
  );

  factory RepoViewRoute.from(Repo repo) => RepoViewRoute(
        repo.ownerName,
        repo.repoName,
      );

  final String ownerName;
  final String repoName;

  static const name = 'repo-view';

  @override
  Page<void> buildPage(BuildContext context) => TransitionPage.fade(
        name: name,
        child: ProviderScope(
          overrides: [
            selectedRepoProvider.overrideWithProvider(
              selectedRepoProviderFamily(
                SelectedRepoParameter(
                  ownerName: ownerName,
                  repoName: repoName,
                ),
              ),
            ),
          ],
          child: const RepoViewPage(),
        ),
      );
}

/// アバタープレビュー画面
class AvatarPreviewRoute extends GoRouteData {
  const AvatarPreviewRoute(
    this.ownerName,
    this.repoName, {
    this.$extra,
  });

  factory AvatarPreviewRoute.from(Repo repo) => AvatarPreviewRoute(
        repo.ownerName,
        repo.repoName,
        $extra: repo,
      );

  final String ownerName;
  final String repoName;
  final Repo? $extra;

  static const name = 'avatar';

  @override
  Page<void> buildPage(BuildContext context) => TransitionPage.none(
        name: name,
        child: ProviderScope(
          overrides: [
            selectedRepoProvider.overrideWithProvider(
              selectedRepoProviderFamily(
                SelectedRepoParameter(
                  ownerName: ownerName,
                  repoName: repoName,
                  extra: $extra,
                ),
              ),
            ),
          ],
          child: const AvatarPreviewPage(),
        ),
      );
}

/// エラー画面
class ErrorRoute extends GoRouteData {
  const ErrorRoute(
    this.error,
  );

  final Exception? error;

  static const name = 'error';

  @override
  Page<void> buildPage(BuildContext context) => TransitionPage.fade(
        name: name,
        child: ErrorPage(error: error),
      );
}

/// 画面遷移の定義Provider
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/repos',
    routes: $appRoutes,

    // エラー画面
    errorPageBuilder: (context, state) =>
        ErrorRoute(state.error).buildPage(context),
    observers: [pageRouteObserver],
    debugLogDiagnostics: !kReleaseMode,

    // URLの#を除去する
    urlPathStrategy: UrlPathStrategy.path,
    navigatorBuilder: (context, state, child) =>
        responsiveWrapperBuilder(context, child),
  ),
);

Widget responsiveWrapperBuilder(
  BuildContext context,
  Widget? child,
) {
  return ResponsiveWrapper.builder(
    child,
    //    0 ----- AUTOSCALE ----- 320
    //  320 -----   RESIZE  ----- 768(MOBILE)
    //  768 -----   RESIZE  ----- 1024(TABLET)
    // 1024 -----   RESIZE  ----- ∞(DESKTOP)
    breakpoints: [
      const ResponsiveBreakpoint.resize(320, name: MOBILE),
      const ResponsiveBreakpoint.resize(768, name: TABLET),
      const ResponsiveBreakpoint.resize(1024, name: DESKTOP),
    ],
    minWidth: 320,
    maxWidth: 1600,
    defaultScale: true,
    // ignore: use_colored_box
    background: Container(
      color: Theme.of(context).colorScheme.surface,
    ),
    debugLog: !kReleaseMode,
  );
}

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
class TransitionPage extends CustomTransitionPage<void> {
  const TransitionPage({
    required String name,
    required super.child,
    required super.transitionsBuilder,
    super.transitionDuration,
    super.maintainState,
    super.fullscreenDialog,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    super.key,
    super.arguments,
    super.restorationId,
  }) : super(
          name: name,
        );

  factory TransitionPage.none({
    required Widget child,
    required String name,
  }) =>
      TransitionPage(
        name: name,
        child: child,
        transitionsBuilder: _noneTransitionsBuilder,
      );

  factory TransitionPage.fade({
    required Widget child,
    required String name,
  }) =>
      TransitionPage(
        name: name,
        child: child,
        transitionsBuilder: _fadeTransitionsBuilder,
      );

  static Widget _fadeTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);

  static Widget _noneTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
