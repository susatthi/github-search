// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../../localizations/strings.g.dart';
import 'search_repos_sort_selector_bottom_sheet.dart';

/// リポジトリ検索用ソートボタン
class RepoSortButton extends StatelessWidget {
  const RepoSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) => const SearchReposSortSelectorBottomSheet(),
      ),
      icon: const Icon(Icons.sort),
      tooltip: i18n.sort,
    );
  }
}
