// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_search/src/config/constants.dart';
import 'package:github_search/src/gen/fonts.gen.dart';
import 'package:github_search/src/presentation/pages/repo/repo_index_page.dart';
import 'package:github_search/src/presentation/pages/repo/repo_view_page.dart';
import 'package:github_search/src/presentation/widgets/repo/repo_detail_view_controller.dart';
import 'package:github_search/src/utils/extensions.dart';
import 'package:go_router/go_router.dart';

class GithubSearchApp extends StatelessWidget {
  GithubSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'GithubSearch',
      onGenerateTitle: (context) => context.locale().appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: FontFamily.murecho,
      ),
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
                  repoDetailViewControllerProviderFamily({
                    kPageParamKeyOwnerName:
                        state.params[kPageParamKeyOwnerName]!,
                    kPageParamKeyRepoName: state.params[kPageParamKeyRepoName]!,
                  }),
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
        title: Text(context.locale().error),
      ),
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
    debugLogDiagnostics: !kReleaseMode,
  );
}
