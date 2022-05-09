// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../pages/repo/repo_search_page.dart';
import 'repo_search_repos_query.dart';
import 'repo_search_text_field.dart';

/// リポジトリ検索用テキストボタン
class RepoSearchTextButton extends ConsumerWidget {
  const RepoSearchTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // リポジトリ一覧画面とリポジトリ検索画面で重なり合うように
    // 左側に良い感じに余白を設ける
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: TextButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).backgroundColor,
          ),
          foregroundColor: MaterialStateProperty.all<Color?>(
            Theme.of(context).textTheme.titleMedium?.color,
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero,
          ),
        ),
        child: RepoSearchTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          onTap: () {
            // リポジトリ検索画面に遷移する
            context.goNamed(RepoSearchPage.name);
          },
          onTappedDelete: () {
            // 検索文字列をクリアしてリポジトリ検索画面に遷移する
            ref.read(repoSearchReposQueryProvider.notifier).query = '';
            context.goNamed(RepoSearchPage.name);
          },
        ),
      ),
    );
  }
}
