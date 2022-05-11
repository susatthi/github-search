import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 検索用AppBar
class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
    this.title,
    this.actions,
    this.flexibleSpace,
    required this.backgroundColor,
    this.floating = false,
    this.pinned = false,
  }) : super(key: key);

  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final Color backgroundColor;
  final bool floating;
  final bool pinned;

  static const defaultToolBarHeight = kToolbarHeight + 8 * 2;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      backgroundColor: backgroundColor,
      iconTheme: IconTheme.of(context),
      actionsIconTheme: IconTheme.of(context),
      titleSpacing: 0,
      floating: floating,
      pinned: pinned,
      toolbarHeight: defaultToolBarHeight,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
