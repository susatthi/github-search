// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localizations/strings.g.dart';
import 'repo_search_repos_query.dart';

/// リポジトリ検索用テキストフィールド
class RepoSearchTextField extends ConsumerStatefulWidget {
  const RepoSearchTextField({Key? key}) : super(key: key);

  @override
  ConsumerState<RepoSearchTextField> createState() =>
      _RepoSearchTextFieldState();
}

class _RepoSearchTextFieldState extends ConsumerState<RepoSearchTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(repoSearchReposQueryProvider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: i18n.searchRepos,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: const Icon(Icons.search),
        // 1文字以上あるときだけ削除アイコンを表示する
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (_, value, __) {
            return Visibility(
              visible: value.text.isNotEmpty,
              child: InkWell(
                onTap: _controller.clear,
                child: const Icon(Icons.close),
              ),
            );
          },
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      // キーボードのEnterキー押下時に検索を実行する
      onSubmitted: (text) {
        ref.read(repoSearchReposQueryProvider.notifier).query = text;
      },
      // キーボードのEnterキーを検索ボタンにする
      textInputAction: TextInputAction.search,
    );
  }
}
