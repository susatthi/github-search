// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:github_search/ui/page/repo/index_page.dart';
import 'package:github_search/ui/page/repo/view_page.dart';
import 'package:go_router/go_router.dart';

class GithubSearchApp extends StatelessWidget {
  GithubSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      title: 'GithubSearch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      ),
      // リポジトリ詳細画面
      GoRoute(
        path: RepoViewPage.path,
        name: RepoViewPage.name,
        builder: (context, state) => RepoViewPage(
          id: state.params['id']!,
        ),
      ),
    ],
    // エラー画面
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('エラー'),
      ),
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );
}
