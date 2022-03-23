// Copyright 2022 Keyber Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// リポジトリ詳細画面
class RepoViewPage extends StatelessWidget {
  const RepoViewPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const name = 'repoView';
  static const path = '/repo/:id';

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubSearch'),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
