// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entity/url_launch_data.dart';

/// URL起動Repositoryプロバイダー
final urlLauncherRepositoryProvider = Provider<UrlLauncherRepository>(
  (ref) => throw UnimplementedError('Provider was not initialized'),
);

/// URL起動Repository
abstract class UrlLauncherRepository {
  /// URLを起動する
  ///
  /// URLが起動できない場合は [UrlLauncherException] を投げる。
  Future<void> launch(UrlLaunchData data);
}
