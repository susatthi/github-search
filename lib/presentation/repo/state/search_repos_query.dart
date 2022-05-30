// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/env.dart';
import '../../../config/env_define.dart';

/// リポジトリ検索文字列初期値プロバイダー
final repoSearchReposInitQueryProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    dartDefineKeyDefaultSearchValue,
    //ignore: avoid_redundant_argument_values
    defaultValue: Env.defaultSearchValue,
  ),
);

/// リポジトリ検索文字列プロバイダー
final repoSearchReposQueryProvider = StateProvider<String>(
  (ref) => ref.read(repoSearchReposInitQueryProvider),
);
