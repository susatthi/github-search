// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// リポジトリ検索文字列
final searchReposQueryProvider = StateProvider<String>((ref) => '');

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
    _controller.text = ref.read(searchReposQueryProvider);
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
        hintText: 'リポジトリを検索',
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: InkWell(
          child: const Icon(Icons.search),
          onTap: () {
            FocusScope.of(context).unfocus();
            ref.read(searchReposQueryProvider.notifier).state =
                _controller.text;
          },
        ),
      ),
      onSubmitted: (text) {
        ref.read(searchReposQueryProvider.notifier).state = text;
      },
    );
  }
}
