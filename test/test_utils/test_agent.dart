// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/config/app.dart';
import 'package:github_search/domain/repositories/app_data_repository.dart';
import 'package:github_search/domain/repositories/query_history_repository.dart';
import 'package:github_search/domain/repositories/repo_repository.dart';
import 'package:github_search/infrastructure/github/http_client.dart';
import 'package:github_search/infrastructure/github/repo_repository.dart';
import 'package:github_search/infrastructure/hive/app_data_repository.dart';
import 'package:github_search/infrastructure/isar/collections/query_history.dart';
import 'package:github_search/infrastructure/isar/query_history_repository.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:github_search/presentation/repo/components/search_repos_query.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
// ignore: unused_import
import 'package:isar/src/version.dart';
import 'package:path/path.dart' as path;
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
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
    repoSearchReposInitQueryStringProvider.overrideWithValue('flutter'),
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

    // 一部テストで下記エラーがでるのでPathProviderをモック化
    // The following MissingPluginException was thrown running a test (but after
    // the test had completed):MissingPluginException(No implementation found
    // for method getTemporaryDirectory on channel plugins.flutter.io/path_provider_macos)
    // see: https://qiita.com/teriyaki398_/items/642be2f0ed1e87d8ae38
    // see: https://stackoverflow.com/questions/62597011/mock-getexternalstoragedirectory-on-flutter
    PathProviderPlatform.instance = MockPathProviderPlatform();

    const MethodChannel('com.tekartik.sqflite').setMockMethodCallHandler(
      (MethodCall methodCall) async {
        if (methodCall.method == 'getDatabasesPath') {
          return path.join(
            TestDirectory.rootDir.path,
            'sqflite',
            'dummy.db',
          );
        }
        if (methodCall.method == 'openDatabase') {
          final args = methodCall.arguments as Map<dynamic, dynamic>;
          return databaseFactoryFfi.openDatabase(args['path'] as String);
        }
      },
    );

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

    // Isar.initializeIsarCore() 内部で Isar のライブラリを GitHub
    // （例: https://github.com/isar/isar-core/releases/download/2.5.13/libisar_macos.dylib）
    // からダウンロードしているため一時的にインターネットに出られるようにしている。
    // ダウンロードしたライブラリファイルは ./dart_tool/ 配下に
    // Isarコアバージョン毎にフォルダを作成して保存することにしている。
    final libraryDir = Directory(
      path.join(
        TestDirectory.rootDir.path,
        'isar_core_library',
        isarCoreVersion,
      ),
    );
    if (!libraryDir.existsSync()) {
      await libraryDir.create(recursive: true);
    }

    final evacuation = HttpOverrides.current;
    HttpOverrides.global = null;
    await Isar.initializeIsarCore(
      libraries: <Abi, String>{
        Abi.current(): path.join(libraryDir.path, Abi.current().localName),
      },
      download: true,
    );
    HttpOverrides.global = evacuation;

    _isar = await Isar.open(
      directory: testDir.dir.path,
      schemas: [
        QueryHistoryCollectionSchema,
      ],
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
  String get localName {
    switch (Abi.current()) {
      case Abi.androidArm:
      case Abi.androidArm64:
      case Abi.androidIA32:
      case Abi.androidX64:
        return 'libisar.so';
      case Abi.macosArm64:
      case Abi.macosX64:
        return 'libisar.dylib';
      case Abi.linuxX64:
        return 'libisar.so';
      case Abi.windowsArm64:
      case Abi.windowsX64:
        return 'isar.dll';
      default:
        // ignore: only_throw_errors
        throw 'Unsupported processor architecture "${Abi.current()}".'
            'Please open an issue on GitHub to request it.';
    }
  }
}
