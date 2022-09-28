// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localizations/strings.g.dart';
import '../../../../utils/logger.dart';
import 'search_repos_query.dart';

/// リポジトリ検索用テキストフィールド
class SearchReposTextField extends ConsumerStatefulWidget {
  const SearchReposTextField({
    super.key,
    this.readOnly = false,
    this.prefixIcon,
    this.onTap,
    this.onTappedDelete,
    this.controller,
  });

  /// trueにすると読み取り専用になる
  final bool readOnly;

  /// TextFieldの先頭にアイコンを表示する
  final Widget? prefixIcon;

  /// TextFieldをタップしたときのイベント
  final GestureTapCallback? onTap;

  /// 削除ボタンをタップしたあとのイベント
  final GestureTapCallback? onTappedDelete;

  /// TextEditingController
  final TextEditingController? controller;

  @override
  ConsumerState<SearchReposTextField> createState() =>
      SearchReposTextFieldState();
}

@visibleForTesting
class SearchReposTextFieldState extends ConsumerState<SearchReposTextField> {
  late TextEditingController controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();

    final queryString = ref.read(searchReposQueryStringProvider);
    controller
      ..text = queryString
      // 使い勝手を良くするために表示されたときは全選択状態にする
      ..selection = TextSelection(
        baseOffset: 0,
        extentOffset: queryString.length,
      );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 検索文字列はアプリ内で1であるため、別で検索文字列が更新されたら同期する
    ref.listen(searchReposQueryStringProvider, (previous, next) {
      logger.v(
        'Update query: current = ${controller.text}, '
        'next = $next',
      );
      controller.text = next;
    });

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: i18n.searchRepos,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: widget.prefixIcon,
        // 1文字以上あるときだけ削除アイコンを表示する
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, __) {
            logger.v('Update delete icon: visible = ${value.text.isNotEmpty}');
            return Visibility(
              visible: value.text.isNotEmpty,
              child: InkWell(
                onTap: () {
                  // 検索文字列をクリアする
                  controller.clear();

                  // onChanged が呼ばれないので明示的に入力中検索文字列状態を空にする
                  ref
                      .read(searchReposEnteringQueryStringProvider.notifier)
                      .state = '';

                  widget.onTappedDelete?.call();
                },
                child: Icon(
                  Icons.close,
                  color: IconTheme.of(context).color,
                ),
              ),
            );
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      // 入力文字が変更されたら状態を更新する
      onChanged: (text) {
        ref.read(searchReposEnteringQueryStringUpdater)(text);
      },
      // キーボードのEnterキー押下時に検索を実行する
      onSubmitted: (text) {
        logger.i('Called onSubmitted(): text = $text');
        ref.read(searchReposQueryStringUpdater)(text);
        Navigator.of(context).pop();
      },
      // キーボードのEnterキーを検索ボタンにする
      textInputAction: TextInputAction.search,
      // trueにすると画面表示時に自動でキーボードを出してくれる
      autofocus: !widget.readOnly,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      focusNode: focusNode,
    );
  }
}
