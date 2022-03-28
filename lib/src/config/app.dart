// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/gen/fonts.gen.dart';
import 'package:github_search/src/localizations/l10n.dart';
import 'package:github_search/src/presentation/pages/repo/repo_index_page.dart';
import 'package:github_search/src/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view_controller.dart';
import 'package:go_router/go_router.dart';

class GithubSearchApp extends StatelessWidget {
  GithubSearchApp({
    Key? key,
    this.home,
  }) : super(key: key);

  /// 初期表示画面（テスト用）
  @visibleForOverriding
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: FontFamily.murecho,
    );
    if (home != null) {
      // テスト用
      return MaterialApp(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        title: 'GithubSearchTest',
        onGenerateTitle: (context) => L10n.of(context).appName,
        theme: theme,
        home: home,
      );
    }

    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      title: 'GithubSearch',
      onGenerateTitle: (context) => L10n.of(context).appName,
      theme: theme,
    );
  }

  /// 画面遷移の定義
  final _router = GoRouter(
    initialLocation: RepoIndexPage.path,
    routes: [
      // リポジトリ一覧画面
      GoRoute(
        path: RepoIndexPage.path,
        name: RepoIndexPage.name,
        builder: (context, state) => const RepoIndexPage(),
        routes: [
          // リポジトリ詳細画面
          GoRoute(
            path: RepoViewPage.path,
            name: RepoViewPage.name,
            builder: (context, state) => ProviderScope(
              overrides: [
                repoDetailViewControllerProvider.overrideWithProvider(
                  repoDetailViewControllerProviderFamily(
                    RepoDetailViewParameter.from(state),
                  ),
                ),
              ],
              child: const RepoViewPage(),
            ),
          ),
        ],
      ),
    ],
    // エラー画面
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).error),
      ),
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
    debugLogDiagnostics: !kReleaseMode,
  );
}
