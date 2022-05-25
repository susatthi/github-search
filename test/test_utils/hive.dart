// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:github_search/infrastructure/hive/app_data_repository.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

final _random = Random();
String _tempPath =
    path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');

/// tempディレクトリを作成して返す
Future<Directory> _createTempDir() async {
  final name = _random.nextInt(pow(2, 32) as int);
  final dir = Directory(path.join(_tempPath, '${name}_tmp'));

  if (dir.existsSync()) {
    await dir.delete(recursive: true);
  }

  await dir.create(recursive: true);
  return dir;
}

/// tempディレクトリを削除する
void _deleteTempDir(Directory dir) {
  if (dir.existsSync()) {
    dir.deleteSync();
  }
}

/// モック版のアプリデータ用HiveBoxを返す
Future<Directory> openAppDataBox() async {
  final tempDir = await _createTempDir();
  Hive.init(tempDir.path);
  final box = await Hive.openBox<dynamic>(hiveBoxNameAppData);
  await box.clear();
  return tempDir;
}

/// モック版のアプリデータ用HiveBoxをクローズする
Future<void> closeAppDataBox(Directory dir) async {
  await Hive.deleteFromDisk();
  _deleteTempDir(dir);
}
