// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../presentation/components/repo/repo_detail_view_notifier.dart';
import '../presentation/pages/error/error_page.dart';
import '../presentation/pages/repo/repo_index_page.dart';
import '../presentation/pages/repo/repo_view_page.dart';

/// 画面遷移の定義
final router = GoRouter(
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
