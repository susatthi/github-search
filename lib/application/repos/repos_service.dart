// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repos_query.dart';

/// リポジトリ一覧サービスプロバイダー
final reposServiceProvider = Provider(
  ReposService.new,
);

/// リポジトリ一覧サービス
class ReposService {
  const ReposService(this.ref);

  final Ref ref;

  /// 次のページを取得する
  Future<void> fetchNextPage() async {
    await ref.read(reposQueryDataProvider.notifier).fetchNextPage();
  }
}
