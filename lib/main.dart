// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'domain/repository/app_data/app_data_repository.dart';
import 'domain/repository/query_history/query_history_repository.dart';
import 'domain/repository/repo/repo_repository.dart';
import 'infrastructure/github/api.dart';
import 'infrastructure/github/http_client.dart';
import 'infrastructure/github/repo/repo_repository.dart';
import 'infrastructure/hive/app_data/app_data_repository.dart';
import 'infrastructure/hive/hive.dart';
import 'infrastructure/isar/isar.dart';
import 'infrastructure/isar/query_history/query_history_repository.dart';
import 'presentation/app.dart';
import 'util/localization/strings.g.dart';
import 'util/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // URLの#を除去する
  usePathUrlStrategy();

  // fast_i18n の初期化
  LocaleSettings.useDeviceLocale();

  // hive の初期化
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<dynamic>(hiveBoxNameAppData);
  // await Hive.box<dynamic>(hiveBoxNameAppData).clear();

  // isar の初期化
  var path = '';
  if (!UniversalPlatform.isWeb) {
    final dir = await getApplicationSupportDirectory();
    path = dir.path;
  }
  final isar = await initIsar(
    directory: path,
  );

  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(),
      ],
      overrides: [
        // DataSources
        isarProvider.overrideWithValue(isar),
        // Repositories
        appDataRepositoryProvider.overrideWith(
          (ref) => HiveAppDataRepository(
            box: Hive.box<dynamic>(hiveBoxNameAppData),
          ),
        ),
        repoRepositoryProvider.overrideWith(
          (ref) => GitHubRepoRepository(
            api: const GitHubApi(),
            client: ref.watch(githubHttpClientProvider),
          ),
        ),
        queryHistoryRepositoryProvider.overrideWith(
          (ref) => IsarQueryHistoryRepository(
            isar: ref.watch(isarProvider),
          ),
        ),
      ],
      child: const GitHubSearchApp(),
    ),
  );
}
