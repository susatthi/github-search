// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_search/localizations/strings.g.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

export 'package:golden_toolkit/golden_toolkit.dart';

/// [GoldenToolkit]を使用して、複数デバイスでゴールデンテストを実行する。
@isTest
void testDeviceGoldens(
  String description,
  FutureOr<void> Function(WidgetTester tester) body,
) {
  return testGoldens(description, (tester) async {
    return GoldenToolkit.runWithConfiguration(
      () async {
        await loadAppFonts();
        await body(tester);
      },
      config: GoldenToolkitConfiguration(
        defaultDevices: [
          Device.phone.copyWith(
            name: 'phone-1',
          ),
          Device.phone.copyWith(
            name: 'phone-2',
            textScale: 2,
          ),
          Device.iphone11.copyWith(
            name: 'iphone11-1',
          ),
          Device.iphone11.copyWith(
            name: 'iphone11-2',
            textScale: 2,
          ),
          Device.tabletPortrait.copyWith(
            name: 'tablet-portrait-1',
          ),
          Device.tabletPortrait.copyWith(
            name: 'tablet-portrait-2',
            textScale: 2,
          ),
          Device.tabletLandscape.copyWith(
            name: 'tablet-landscape-1',
          ),
          Device.tabletLandscape.copyWith(
            name: 'tablet-landscape-2',
            textScale: 2,
          ),
        ],
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
