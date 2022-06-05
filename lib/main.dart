// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'config/app.dart';
import 'domain/repositories/app_data/app_data_repository.dart';
import 'domain/repositories/query_history/query_history_repository.dart';
import 'domain/repositories/repo/repo_repository.dart';
import 'infrastructure/github/repo/repo_repository.dart';
import 'infrastructure/hive/app_data/app_data_repository.dart';
import 'infrastructure/isar/query_history/collections/query_history.dart';
import 'infrastructure/isar/query_history/query_history_repository.dart';
import 'localizations/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // fast_i18n の初期化
  LocaleSettings.useDeviceLocale();

  // hive の初期化
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(hiveBoxNameAppData);

  // isar の初期化
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    directory: dir.path,
    schemas: [
      QueryHistoryCollectionSchema,
    ],
  );

  runApp(
    ProviderScope(
      overrides: [
        // DataSources
        isarProvider.overrideWithValue(isar),
        // Repositories
        appDataRepositoryProvider
            .overrideWithProvider(hiveAppDataRepositoryProvider),
        repoRepositoryProvider
            .overrideWithProvider(githubRepoRepositoryProvider),
        queryHistoryRepositoryProvider
            .overrideWithProvider(isarQueryHistoryRepositoryProvider),
      ],
      child: const GitHubSearchApp(),
    ),
  );
}
