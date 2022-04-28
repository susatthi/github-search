// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

import '../assets/fonts.gen.dart';
import '../localizations/strings.g.dart';
import '../presentation/components/repo/repo_detail_view_controller.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/repo/repo_index_page.dart';
import '../presentation/pages/repo/repo_view_page.dart';

/// GitHubSearch アプリ
class GitHubSearchApp extends StatelessWidget {
  const GitHubSearchApp({
    Key? key,
    this.home,
  }) : super(key: key);

  /// 初期表示画面（テスト用）
  @visibleForOverriding
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: _GitHubSearchApp(
        home: home,
      ),
    );
  }
}

class _GitHubSearchApp extends StatelessWidget {
  _GitHubSearchApp({
    Key? key,
    this.home,
  }) : super(key: key);

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
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: LocaleSettings.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
        title: 'GitHubSearchTest',
        onGenerateTitle: (context) => i18n.appName,
        theme: theme,
        home: home,
      );
    }

    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: LocaleSettings.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      title: 'GitHubSearch',
      onGenerateTitle: (context) => i18n.appName,
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
    ],
    // エラー画面
    errorBuilder: (context, state) => ErrorPage(
      error: state.error,
    ),
    debugLogDiagnostics: !kReleaseMode,
  );
}
