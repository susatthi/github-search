// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/router.dart';
import 'package:github_search/presentation/pages/common/error_page.dart';
import 'package:github_search/presentation/pages/repo/repo_index_page.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../test_utils/hive.dart';
import '../test_utils/mocks.dart';

class _MockPageRoute extends Mock implements PageRoute<dynamic> {}

class _MockRoute extends Mock implements Route<dynamic> {}

class _MockRouteAware extends Mock implements PageRouteAware {
  int didPushCount = 0;
  final didPushNextCountMap = <Route<dynamic>, int>{};
  final didPopCountMap = <Route<dynamic>, int>{};
  final didPopNextCountMap = <Route<dynamic>, int>{};

  @override
  void didPopNext(Route<dynamic> nextRoute) {
    didPopNextCountMap.putIfAbsent(nextRoute, () => 1);
  }

  @override
  void didPush() {
    didPushCount += 1;
  }

  @override
  void didPop(Route<dynamic> previousRoute) {
    didPopCountMap.putIfAbsent(previousRoute, () => 1);
  }

  @override
  void didPushNext(Route<dynamic> nextRoute) {
    didPushNextCountMap.putIfAbsent(nextRoute, () => 1);
  }
}

class _EmptyPageRouteAware extends PageRouteAware {}

void main() {
  late Directory tmpDir;
  setUp(() async {
    tmpDir = await openAppDataBox();
  });

  tearDown(() async {
    await closeAppDataBox(tmpDir);
  });

  group('routerProvider', () {
    testWidgets('存在しないパスに遷移するとエラー画面を表示するはず', (tester) async {
      await tester.pumpWidget(mockGitHubSearchApp());
      await tester.pumpAndSettle();

      expect(find.byType(RepoIndexPage), findsOneWidget);
      expect(find.byType(ErrorPage), findsNothing);

      // 存在しないパスに遷移する
      final state = tester.firstState(find.byType(RepoIndexPage));
      state.context.go('/unknown');
      await tester.pump();

      // エラー画面が表示されるはず
      await tester.pump();
      expect(find.byType(ErrorPage), findsOneWidget);
    });
  });
  group('PageRouteObserver', () {
    test('calls correct listeners', () {
      final observer = PageRouteObserver();
      final pageRouteAware1 = _MockRouteAware();
      final route1 = _MockPageRoute();
      observer.subscribe(pageRouteAware1, route1);
      expect(pageRouteAware1.didPushCount, 1);

      final pageRouteAware2 = _MockRouteAware();
      final route2 = _MockPageRoute();
      observer.didPush(route2, route1);
      expect(pageRouteAware1.didPushNextCountMap[route2] ?? 0, 1);

      observer.subscribe(pageRouteAware2, route2);
      expect(pageRouteAware2.didPushCount, 1);

      observer.didPop(route2, route1);
      expect(pageRouteAware2.didPopCountMap[route1] ?? 0, 1);
      expect(pageRouteAware1.didPopNextCountMap[route2] ?? 0, 1);
    });

    test('does not call listeners for non-PageRoute', () {
      final observer = PageRouteObserver();
      final pageRouteAware = _MockRouteAware();
      final pageRoute = _MockPageRoute();
      final route = _MockRoute();
      observer.subscribe(pageRouteAware, pageRoute);
      expect(pageRouteAware.didPushCount, 1);

      observer.didPush(route, pageRoute);
      observer.didPop(route, pageRoute);

      expect(pageRouteAware.didPushCount, 1);
      expect(pageRouteAware.didPopCountMap[route] ?? 0, 0);
    });

    test('does not call listeners when already subscribed', () {
      final observer = PageRouteObserver();
      final pageRouteAware = _MockRouteAware();
      final pageRoute = _MockPageRoute();
      observer.subscribe(pageRouteAware, pageRoute);
      observer.subscribe(pageRouteAware, pageRoute);
      expect(pageRouteAware.didPushCount, 1);
    });

    test('does not call listeners when unsubscribed', () {
      final observer = PageRouteObserver();
      final pageRouteAware = _MockRouteAware();
      final pageRoute = _MockPageRoute();
      final nextPageRoute = _MockPageRoute();
      observer.subscribe(pageRouteAware, pageRoute);
      observer.subscribe(pageRouteAware, nextPageRoute);
      expect(pageRouteAware.didPushCount, 2);

      observer.unsubscribe(pageRouteAware);

      observer.didPush(nextPageRoute, pageRoute);
      observer.didPop(nextPageRoute, pageRoute);

      expect(pageRouteAware.didPushCount, 2);
      expect(pageRouteAware.didPopCountMap[pageRoute] ?? 0, 0);
      expect(pageRouteAware.didPopCountMap[nextPageRoute] ?? 0, 0);
    });

    test('releases reference to route when unsubscribed', () {
      final observer = PageRouteObserver();
      final pageRouteAware = _MockRouteAware();
      final page2RouteAware = _MockRouteAware();
      final pageRoute = _MockPageRoute();
      final nextPageRoute = _MockPageRoute();
      observer.subscribe(pageRouteAware, pageRoute);
      observer.subscribe(pageRouteAware, nextPageRoute);
      observer.subscribe(page2RouteAware, pageRoute);
      observer.subscribe(page2RouteAware, nextPageRoute);
      expect(pageRouteAware.didPushCount, 2);
      expect(page2RouteAware.didPushCount, 2);

      expect(observer.debugObservingRoute(pageRoute), true);
      expect(observer.debugObservingRoute(nextPageRoute), true);

      observer.unsubscribe(pageRouteAware);

      expect(observer.debugObservingRoute(pageRoute), true);
      expect(observer.debugObservingRoute(nextPageRoute), true);

      observer.unsubscribe(page2RouteAware);

      expect(observer.debugObservingRoute(pageRoute), false);
      expect(observer.debugObservingRoute(nextPageRoute), false);
    });

    test('カバレッジ率あげるためにPageRouteAwareの各メソッドも呼んでおく', () {
      final observer = PageRouteObserver();
      final pageRouteAware1 = _EmptyPageRouteAware();
      final route1 = _MockPageRoute();
      observer.subscribe(pageRouteAware1, route1);

      final pageRouteAware2 = _EmptyPageRouteAware();
      final route2 = _MockPageRoute();
      observer.didPush(route2, route1);
      observer.subscribe(pageRouteAware2, route2);
      observer.didPop(route2, route1);
    });
  });
}
