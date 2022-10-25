// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

// ignore_for_file: depend_on_referenced_packages

import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/domain/repository/app_data/app_data_repository.dart';
import 'package:github_search/domain/repository/query_history/query_history_repository.dart';
import 'package:github_search/domain/repository/repo/repo_repository.dart';
import 'package:github_search/domain/state/search_repos_query.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/repo/repo_repository.dart';
import 'package:github_search/infrastructure/hive/app_data/app_data_repository.dart';
import 'package:github_search/infrastructure/hive/hive.dart';
import 'package:github_search/infrastructure/isar/isar.dart';
import 'package:github_search/infrastructure/isar/query_history/query_history_repository.dart';
import 'package:github_search/presentation/app.dart';
import 'package:github_search/presentation/component/cached_circle_avatar.dart';
import 'package:github_search/presentation/page/repo/component/readme_markdown.dart';
import 'package:github_search/util/localization/strings.g.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'mocks.dart';

const defaultLocale = 'en';
const locale = String.fromEnvironment('locale', defaultValue: defaultLocale);

/// テストエージェント
class TestAgent {
  TestAgent() {
    // url_launcher のモック化
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
  }

  final defaultOverrides = <Override>[
    // リポジトリの実装をDI
    appDataRepositoryProvider
        .overrideWithProvider(hiveAppDataRepositoryProvider),
    repoRepositoryProvider.overrideWithProvider(githubRepoRepositoryProvider),
    queryHistoryRepositoryProvider
        .overrideWithProvider(isarQueryHistoryRepositoryProvider),
    // GitHubアクセストークンをダミー文字列にする
    githubAccessTokenProvider.overrideWithValue('dummy'),
    // モック版のHTTPクライアントを使う
    httpClientProvider.overrideWithValue(mockHttpClient),
    // リポジトリ検索文字列の初期値を設定する
    searchReposInitQueryProvider.overrideWithValue('flutter'),
    // モック版のキャッシュマネージャーを使う
    cachedCircleAvatarCacheManagerProvider
        .overrideWithValue(MockCacheManager()),
    // 常にエラーを返すキャッシュマネージャーを使う
    readmeMarkdownCacheManagerProvider
        .overrideWithValue(MockCacheManagerError()),
  ];

  List<Override>? addOverrides;

  final mockUrlLauncherPlatform = MockUrlLauncherPlatform();

  final mockGoRouter = MockGoRouter();

  final hiveTestAgent = HiveTestAgent();
  final isarTestAgent = IsarTestAgent();
  final providerContainerTestAgent = ProviderContainerTestAgent();

  Future<void> setUp({
    List<Override>? overrides,
  }) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // dart-define で与えられた言語情報を設定する
    LocaleSettings.setLocaleRaw(locale);

    // Hive のセットアップ
    await hiveTestAgent.setUp();

    // Isar のセットアップ
    await isarTestAgent.setUp();

    addOverrides = overrides;
  }

  /// モック版のProviderContainer を生成する
  ProviderContainer mockContainer({
    List<Override>? overrides,
  }) {
    final container = providerContainerTestAgent.container;
    if (container != null) {
      return container;
    }

    providerContainerTestAgent.setUp(
      overrides: _generateOverrides(overrides),
    );
    return providerContainerTestAgent.container!;
  }

  /// モック版の GitHubSearchApp を生成する
  Widget mockApp({
    List<Override>? overrides,
    Widget? home,
  }) {
    return ProviderScope(
      overrides: _generateOverrides(overrides),
      child: GitHubSearchApp(
        home: home,
      ),
    );
  }

  List<Override> _generateOverrides(
    List<Override>? overrides,
  ) =>
      [
        ...defaultOverrides,
        isarProvider.overrideWithValue(isarTestAgent.isar),
        ...?addOverrides,
        ...?overrides,
      ];

  Future<void> tearDown() async {
    mockUrlLauncherPlatform.calledUrls.clear();
    mockGoRouter.calledLocations.clear();
    await hiveTestAgent.tearDown();
    await isarTestAgent.tearDown();
    providerContainerTestAgent.tearDown();
  }
}

class ProviderContainerTestAgent {
  ProviderContainer? _container;
  ProviderContainer? get container => _container;

  void setUp({
    List<Override>? overrides,
  }) {
    _container = ProviderContainer(
      overrides: overrides ?? [],
    );
  }

  void tearDown() {
    _container?.dispose();
    _container = null;
  }
}

class TestDirectory {
  /// テストルートディレクトリ
  static final rootDir = Directory(
    path.join(
      Directory.current.path,
      '.dart_tool',
      'test',
      'tmp',
    ),
  );

  /// テストディレクトリ
  Directory? _dir;
  Directory get dir => _dir!;

  /// テストディレクトリを開く
  Future<void> open({
    String? prefix,
  }) async {
    if (_dir != null) {
      return;
    }

    final name = Random().nextInt(pow(2, 32) as int);
    final effectivePrefix = prefix ?? 'tmp';
    final dir = Directory(path.join(rootDir.path, '${effectivePrefix}_$name'));

    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
    await dir.create(recursive: true);
    _dir = dir;
  }

  /// テストディレクトリを閉じる
  void close() {
    final dir = _dir;
    if (dir == null) {
      return;
    }

    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
      _dir = null;
    }
  }
}

/// Hive のテストエージェント
class HiveTestAgent {
  final testDir = TestDirectory();

  /// セットアップする
  Future<void> setUp() async {
    await testDir.open(prefix: 'hive');
    Hive.init(testDir.dir.path);
    Hive.resetAdapters();
    Hive.registerAdapters();
    final box = await Hive.openBox<dynamic>(hiveBoxNameAppData);
    await box.clear();
  }

  /// 終了する
  Future<void> tearDown() async {
    await Hive.deleteFromDisk();
    testDir.close();
  }
}

/// Isar のテストエージェント
class IsarTestAgent {
  final testDir = TestDirectory();
  Isar? _isar;
  Isar get isar => _isar!;

  /// セットアップする
  Future<void> setUp() async {
    await testDir.open(prefix: 'isar');

    // Isar.initializeIsarCore() で 事前にダウンロードしておいた Isar
    // のライブラリへのパスを指定している。
    final libraryDir = Directory(
      path.join(
        Directory.current.path,
        'test',
        'test_utils',
        'assets',
        'isar_core_library',
      ),
    );
    await Isar.initializeIsarCore(
      libraries: <Abi, String>{
        Abi.current(): path.join(libraryDir.path, Abi.current().remoteName),
      },
    );

    _isar = await initIsar(
      directory: testDir.dir.path,
    );
  }

  /// 終了する
  Future<void> tearDown() async {
    await _isar?.close(deleteFromDisk: true);
    _isar = null;
    testDir.close();
  }
}

/// Copy from 'package:isar/src/native/isar_core.dart';
extension on Abi {
  String get remoteName {
    switch (Abi.current()) {
      case Abi.macosArm64:
      case Abi.macosX64:
        return 'libisar_macos.dylib';
      case Abi.linuxX64:
        return 'libisar_linux_x64.so';
      case Abi.windowsArm64:
        return 'isar_windows_arm64.dll';
      case Abi.windowsX64:
        return 'isar_windows_x64.dll';
    }
    throw UnimplementedError();
  }
}
