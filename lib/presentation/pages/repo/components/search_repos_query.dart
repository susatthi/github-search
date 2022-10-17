// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/exceptions.dart';
import '../../../../domain/repositories/query_history/entities/query_history.dart';
import '../../../../domain/repositories/query_history/query_history_repository.dart';
import '../../../../utils/env/env.dart';
import '../../../../utils/env/env_define.dart';
import '../../../../utils/localizations/strings.g.dart';
import '../../../../utils/logger.dart';
import '../../../components/router.dart';

/// リポジトリ検索文字列初期値プロバイダー
final searchReposInitQueryProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyDefaultSearchValue,
    //ignore: avoid_redundant_argument_values
    defaultValue: Env.defaultSearchValue,
  ),
);

/// リポジトリ検索文字列プロバイダー
final searchReposQueryProvider =
    StateNotifierProvider<SearchReposQueryController, String>(
  (ref) => SearchReposQueryController(
    queryHistoryRepository: ref.watch(queryHistoryRepositoryProvider),
    initQuery: ref.watch(searchReposInitQueryProvider),
  ),
  name: 'searchReposQueryProvider',
);

/// リポジトリ検索文字列コントローラー
class SearchReposQueryController extends StateNotifier<String> {
  SearchReposQueryController({
    required this.queryHistoryRepository,
    required String initQuery,
  }) : super(initQuery);

  final QueryHistoryRepository queryHistoryRepository;

  /// 更新する
  Future<void> update(String queryString) async {
    state = queryString;
    try {
      await queryHistoryRepository.add(
        QueryHistory.create(queryString),
      );
    } on ValidatorException catch (e) {
      logger.i(e);
    }
  }
}

/// 入力中のリポジトリ検索文字列プロバイダー
final searchReposEnteringQueryProvider =
    StateNotifierProvider<SearchReposEnteringQueryController, String>(
  (ref) => SearchReposEnteringQueryController(
    initQuery: ref.watch(searchReposQueryProvider),
  ),
);

/// 入力中のリポジトリ検索文字列コントローラー
class SearchReposEnteringQueryController extends StateNotifier<String> {
  SearchReposEnteringQueryController({
    required String initQuery,
  }) : super(initQuery);

  /// 更新する
  Future<void> update(String queryString) async {
    // もし現在の文字列と同じ場合は更新しない
    if (state != queryString) {
      logger.v(
        'Update searchReposEnteringQueryString: queryString = $queryString',
      );
      state = queryString;
    }
  }
}

/// リポジトリ検索用テキストフィールド
class SearchReposQueryTextField extends ConsumerStatefulWidget {
  const SearchReposQueryTextField({
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
  ConsumerState<SearchReposQueryTextField> createState() =>
      SearchReposQueryTextFieldState();
}

@visibleForTesting
class SearchReposQueryTextFieldState
    extends ConsumerState<SearchReposQueryTextField> {
  late TextEditingController controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();

    final queryString = ref.read(searchReposQueryProvider);
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
    ref.listen(searchReposQueryProvider, (previous, next) {
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
                      .read(searchReposEnteringQueryProvider.notifier)
                      .update('');

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
        ref.read(searchReposEnteringQueryProvider.notifier).update(text);
      },
      // キーボードのEnterキー押下時に検索を実行する
      onSubmitted: (text) {
        logger.i('Called onSubmitted(): text = $text');
        ref.read(searchReposQueryProvider.notifier).update(text);
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

/// リポジトリ検索用テキストボタン
class SearchReposQueryTextButton extends ConsumerWidget {
  const SearchReposQueryTextButton({super.key});

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
            Theme.of(context).colorScheme.background,
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
        child: SearchReposQueryTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          onTap: () {
            // リポジトリ検索画面に遷移する
            const RepoSearchRoute().go(context);
          },
          onTappedDelete: () {
            // 検索文字列をクリアしてリポジトリ検索画面に遷移する
            ref.read(searchReposQueryProvider.notifier).update('');
            const RepoSearchRoute().go(context);
          },
        ),
      ),
    );
  }
}
