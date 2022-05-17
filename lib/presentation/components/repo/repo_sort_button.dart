// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../localizations/strings.g.dart';
import 'repo_sort_selector_bottom_sheet.dart';

/// リポジトリ検索用ソートボタン
class RepoSortButton extends StatelessWidget {
  const RepoSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showMaterialModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const RepoSortSelectorBottomSheet(),
      ),
      icon: const Icon(Icons.sort),
      tooltip: i18n.sort,
    );
  }
}
