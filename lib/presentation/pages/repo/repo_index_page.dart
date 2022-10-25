// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../utils/logger.dart';
import '../../../utils/routing/router.dart';
import '../../components/search_app_bar.dart';
import 'components/repo_list_view.dart';
import 'components/search_repos_query.dart';
import 'components/search_repos_sort.dart';

/// リポジトリ一覧画面
class RepoIndexPage extends StatefulWidget {
  const RepoIndexPage({super.key});

  @override
  State<RepoIndexPage> createState() => RepoIndexPageState();
}

@visibleForTesting
class RepoIndexPageState extends State<RepoIndexPage> with PageRouteAware {
  final animatedBackgroundKey = GlobalKey<AnimatedAppBarBackgroundState>();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SearchAppBar(
            title: const SearchReposQueryTextButton(),
            actions: const [
              SearchReposSortButton(),
            ],
            flexibleSpace: SafeArea(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedAppBarBackground(
                  key: animatedBackgroundKey,
                ),
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
          ),
          SliverRepoListView(
            controller: scrollController,
          ),
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
    scrollController.dispose();
    super.dispose();
  }

  /// この画面から新しい画面をpushしたときに呼ばれる
  @override
  void didPushNext(Route<dynamic> nextRoute) {
    // 遷移先がリポジトリ検索画面の時だけアニメーションする
    if (nextRoute.settings.name == RepoSearchRoute.name) {
      animatedBackgroundKey.currentState?.fill();
    }
  }

  /// 上の画面がpopされてこの画面に戻ったときに呼ばれる
  @override
  void didPopNext(Route<dynamic> nextRoute) {
    // 遷移元がリポジトリ検索画面の時だけアニメーションする
    if (nextRoute.settings.name == RepoSearchRoute.name) {
      animatedBackgroundKey.currentState?.collapse();
    }
  }
}

/// 広がったり閉じたりするアニメーション付きの背景
///
/// 検索用テキストボタン押下でリポジトリ検索画面に遷移する際、検索用テキストボタンの
/// 背景がAppBar全体に広がるアニメーションを表現している。逆に戻ってきた時は閉じる
/// アニメーションをする。
@visibleForTesting
class AnimatedAppBarBackground extends StatefulWidget {
  const AnimatedAppBarBackground({super.key});

  @override
  State<AnimatedAppBarBackground> createState() =>
      AnimatedAppBarBackgroundState();
}

@visibleForTesting
class AnimatedAppBarBackgroundState extends State<AnimatedAppBarBackground> {
  static const animateDuration = Duration(milliseconds: 300);

  // 注意: 検索用テキストフィールドのサイズが変わったら下記のパラメータも変える必要がある
  static const initMargin = EdgeInsets.only(left: 18, right: 48);
  static const initHeight = 48.0;
  static const initRadius = 25.0;

  bool isFilled = false;
  Duration duration = animateDuration;
  EdgeInsets margin = initMargin;
  double height = initHeight;
  double radius = initRadius;

  /// 広げる
  void fill({
    bool animated = true,
  }) {
    if (isFilled) {
      return;
    }

    logger.v('Start fill animation');
    final size = MediaQuery.of(context).size;
    setState(() {
      isFilled = true;
      duration = animated ? animateDuration : Duration.zero;
      margin = EdgeInsets.zero;
      height = size.height;
      radius = 0;
    });
  }

  /// 畳む
  void collapse({
    bool animated = true,
  }) {
    if (!isFilled) {
      return;
    }

    logger.v('Start collapse animation');
    setState(() {
      isFilled = false;
      duration = animated ? animateDuration : Duration.zero;
      margin = initMargin;
      height = initHeight;
      radius = initRadius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.decelerate,
      duration: duration,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: const SizedBox(
        width: double.infinity,
      ),
    );
  }
}
