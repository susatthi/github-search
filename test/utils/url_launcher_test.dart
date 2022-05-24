// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/utils/url_launcher.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../test_utils/mocks.dart';

/// PlatformException を throw する UrlLauncherPlatform
class ErrorkUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  @override
  Future<bool> launch(
    String url, {
    required bool useSafariVC,
    required bool useWebView,
    required bool enableJavaScript,
    required bool enableDomStorage,
    required bool universalLinksOnly,
    required Map<String, String> headers,
    String? webOnlyWindowName,
  }) {
    throw PlatformException(code: 'code');
  }
}

void main() {
  late MockUrlLauncherPlatform mockUrlLauncherPlatform;
  setUp(() {
    mockUrlLauncherPlatform = MockUrlLauncherPlatform();
    UrlLauncherPlatform.instance = mockUrlLauncherPlatform;
  });

  group('launchUrlInApp()', () {
    test('正常なURLならアプリ内ブラウザが開くはず', () async {
      const urlString = 'https://github.com';

      when(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => true);

      await launchUrlInApp(urlString);

      verify(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).called(1);
    });
    test('不正なURLなら開かないはず（return false）', () async {
      const urlString = 'https://999.168.0.1/';

      when(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => false);

      await launchUrlInApp(urlString);

      verify(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).called(1);
    });
    test('不正なURLなら開かないはず（FormatException）', () async {
      const urlString = 'https://AFEDC:BA98:7654:3210:FEDC:BA98:7654:3210/';

      await launchUrlInApp(urlString);

      verifyNever(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      );
    });

    test('http or https 以外のスキームのURLならArgumentErrorがthrowされるはず', () async {
      const urlString = 'mailto:hoge@sample.com';
      expect(
        () async {
          await launchUrlInApp(urlString);
        },
        throwsArgumentError,
      );
    });
    test('空文字ならArgumentErrorがthrowされるはず', () async {
      const urlString = '';
      expect(
        () async {
          await launchUrlInApp(urlString);
        },
        throwsArgumentError,
      );
    });
    test('PlatformExceptionがthrowされたら開かないはず', () async {
      final errorUrlLauncherPlatform = ErrorkUrlLauncherPlatform();
      UrlLauncherPlatform.instance = errorUrlLauncherPlatform;

      const urlString = 'https://github.com';

      await launchUrlInApp(urlString);

      verifyNever(
        () => mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      );
    });
  });
}
