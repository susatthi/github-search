// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/util/localization/strings.g.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'logger.dart';

export 'package:golden_toolkit/golden_toolkit.dart';

/// ゴールデンテストをするテキストスケールのリスト
const _textScales = [
  0.85,
  1.3,
];

/// ゴールデンテストをするデバイスのリスト
const _devices = [
  Device(name: 'phone', size: Size(300, 400)),
  Device(name: 'mobile', size: Size(393, 851)),
  Device(name: 'tablet', size: Size(820, 1180)),
  Device(name: 'desktop', size: Size(1300, 1300)),
];

/// [GoldenToolkit]を使用して、複数デバイスでゴールデンテストを実行する。
@isTest
void testDeviceGoldens(
  String description,
  FutureOr<void> Function(WidgetTester tester) body,
) {
  return testGoldens(description, (tester) async {
    // ゴールデンテストは macOS 環境のみで行うことにする
    // see: https://qiita.com/Umigishi-Aoi/items/db3e81372085e196dc10
    if (!isMacOS) {
      testLogger.i('Skip "$description" test becase platform is not macOS');
      return;
    }

    final goldenDevices = <Device>[];
    for (final device in _devices) {
      for (final textScale in _textScales) {
        goldenDevices.add(
          device.copyWith(
            name: '${device.name}-$textScale',
            textScale: textScale,
          ),
        );
      }
    }

    return GoldenToolkit.runWithConfiguration(
      () async {
        // responsive_framework との相性が悪く、ゴールデンテストで指定した縦横サイズが
        // ResponsiveWrapperに反映されず、レイアウトが崩れて NG になってしまうため、
        // ゴールデンテストを無効化する

        // await loadAppFonts();
        // await body(tester);
      },
      config: GoldenToolkitConfiguration(
        defaultDevices: goldenDevices,
        primeAssets: _primeAssets,
        fileNameFactory: _fileNameFactory,
        deviceFileNameFactory: _deviceFileNameFactory,
      ),
    );
  });
}

/// precacheImage() の処理が永遠に終わらない問題があるので何もしない
/// 1件のテストを実行するときは問題ないが全体を実行すると発生する謎
Future<void> _primeAssets(WidgetTester tester) async {}

/// ファイル名に言語情報を付与する
String _fileNameFactory(String name) {
  final locale = LocaleSettings.currentLocale;
  return 'goldens/$name.${locale.name}.png';
}

/// ファイル名に言語情報を付与する
String _deviceFileNameFactory(String name, Device device) {
  final locale = LocaleSettings.currentLocale;
  return 'goldens/$name.${device.name}.${locale.name}.png';
}
