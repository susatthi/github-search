// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../config/router.dart';
import '../../../localizations/strings.g.dart';
import '../../../utils/logger.dart';
import '../../components/common/search_app_bar.dart';
import '../../components/repo/repo_list_view.dart';
import '../../components/repo/repo_order_toggle_button.dart';
import '../../components/repo/repo_search_text_button.dart';
import '../../components/repo/repo_sort_selector_dialog.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatefulWidget {
  const RepoIndexPage({Key? key}) : super(key: key);

  static const name = 'repo_index';
  static const path = '/repo';

  @override
  RepoIndexPageState createState() => RepoIndexPageState();
}

class RepoIndexPageState extends State<RepoIndexPage> with RouteAware {
  final _animatedBackgroundKey = GlobalKey<_AnimatedAppBarBackgroundState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SearchAppBar(
            title: const RepoSearchTextButton(),
            actions: [
              const RepoOrderToggleButton(),
              IconButton(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) => const RepoSortSelectorDialog(),
                ),
                icon: const Icon(Icons.sort),
                tooltip: i18n.sort,
              ),
            ],
            flexibleSpace: SafeArea(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _AnimatedAppBarBackground(
                  key: _animatedBackgroundKey,
                ),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
          ),
          const SliverRepoListView(),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageRouteObserver.subscribe(
      this,
      ModalRoute.of<void>(context)! as PageRoute,
    );
  }

  @override
  void dispose() {
    pageRouteObserver.unsubscribe(this);
    super.dispose();
  }

  /// この画面から新しい画面をpushしたときに呼ばれる
  @override
  void didPushNext() {
    logger.v('Call _AnimatedAppBarBackground.fill()');
    _animatedBackgroundKey.currentState?.fill();
  }

  /// 上の画面がpopされてこの画面に戻ったときに呼ばれる
  @override
  void didPopNext() {
    logger.v('Call _AnimatedAppBarBackground.collapse()');
    _animatedBackgroundKey.currentState?.collapse();
  }
}

/// 広がったり閉じたりするアニメーション付きの背景
///
/// 検索用テキストボタン押下でリポジトリ検索画面に遷移する際、検索用テキストボタンの
/// 背景がAppBar全体に広がるアニメーションを表現している。逆に戻ってきた時は閉じる
/// アニメーションをする。
class _AnimatedAppBarBackground extends StatefulWidget {
  const _AnimatedAppBarBackground({Key? key}) : super(key: key);

  @override
  State<_AnimatedAppBarBackground> createState() =>
      _AnimatedAppBarBackgroundState();
}

class _AnimatedAppBarBackgroundState extends State<_AnimatedAppBarBackground> {
  static const _animateDuration = Duration(milliseconds: 300);

  // 注意: 検索用テキストフィールドのサイズが変わったら下記のパラメータも変える必要がある
  static const _initMargin = EdgeInsets.only(left: 18, right: 96);
  static const _initHeight = 48.0;
  static const _initRadius = 25.0;

  bool _isFilled = false;
  Duration _duration = _animateDuration;
  EdgeInsets _margin = _initMargin;
  double _height = _initHeight;
  double _radius = _initRadius;

  /// 広げる
  void fill({
    bool animated = true,
  }) {
    if (_isFilled) {
      return;
    }

    final size = MediaQuery.of(context).size;
    setState(() {
      _isFilled = true;
      _duration = animated ? _animateDuration : Duration.zero;
      _margin = EdgeInsets.zero;
      _height = size.height;
      _radius = 0;
    });
  }

  /// 畳む
  void collapse({
    bool animated = true,
  }) {
    if (!_isFilled) {
      return;
    }
    setState(() {
      _isFilled = false;
      _duration = animated ? _animateDuration : Duration.zero;
      _margin = _initMargin;
      _height = _initHeight;
      _radius = _initRadius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: _duration,
      height: _height,
      margin: _margin,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
      child: const SizedBox(
        width: double.infinity,
      ),
    );
  }
}
