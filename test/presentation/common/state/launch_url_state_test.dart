// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/presentation/common/state/launch_url_state.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher/url_launcher_string.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../test_utils/logger.dart';
import '../../../test_utils/test_agent.dart';

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
  final agent = TestAgent();
  setUp(agent.setUp);
  tearDown(agent.tearDown);

  group('launcher', () {
    test('正常なURLならアプリ内ブラウザが開くはず', () async {
      const urlString = 'https://github.com';

      when(
        () => agent.mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => true);

      await agent.mockContainer().read(launcher)(urlString);

      verify(
        () => agent.mockUrlLauncherPlatform.launch(
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
        () => agent.mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => false);

      await agent.mockContainer().read(launcher)(urlString);

      verify(
        () => agent.mockUrlLauncherPlatform.launch(
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

      await agent.mockContainer().read(launcher)(urlString);

      verifyNever(
        () => agent.mockUrlLauncherPlatform.launch(
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

    test('http or https 以外のスキームのURLなら開かないはず（ArgumentError）', () async {
      const urlString = 'mailto:hoge@sample.com';

      await agent.mockContainer().read(launcher)(urlString);

      verifyNever(
        () => agent.mockUrlLauncherPlatform.launch(
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
    test('空文字なら開かないはず（ArgumentError）', () async {
      const urlString = '';

      await agent.mockContainer().read(launcher)(urlString);

      verifyNever(
        () => agent.mockUrlLauncherPlatform.launch(
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
    test('PlatformExceptionがthrowされたら開かないはず', () async {
      const urlString = 'https://github.com';

      final evacuation = UrlLauncherPlatform.instance;
      UrlLauncherPlatform.instance = ErrorkUrlLauncherPlatform();
      await agent.mockContainer().read(launcher)(urlString);
      UrlLauncherPlatform.instance = evacuation;

      verifyNever(
        () => agent.mockUrlLauncherPlatform.launch(
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
    test('URL起動できることを監視できるはず', () async {
      const urlString = 'https://github.com';
      String? stateUrlString;
      LaunchMode? stateMode;
      LaunchUrlStatus? stateStatus;

      when(
        () => agent.mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => true);

      agent.mockContainer().listen<LaunchUrlState>(
        launchUrlStateProvider,
        (previous, next) {
          testLogger.i(next, null, StackTrace.current);
          stateUrlString = next.urlString;
          stateMode = next.mode;
          stateStatus = next.status;
        },
      );

      final future = agent.mockContainer().read(launcher)(urlString);

      // URL起動前のはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.inAppWebView);
      expect(stateStatus, LaunchUrlStatus.wating);

      await Future.wait([future]);

      // URL起動に成功したはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.inAppWebView);
      expect(stateStatus, LaunchUrlStatus.success);
    });
    test('URL起動できないことを監視できるはず', () async {
      const urlString = 'https://999.168.0.1/';

      String? stateUrlString;
      LaunchMode? stateMode;
      LaunchUrlStatus? stateStatus;

      when(
        () => agent.mockUrlLauncherPlatform.launch(
          urlString,
          useSafariVC: true,
          useWebView: true,
          enableJavaScript: true,
          enableDomStorage: true,
          universalLinksOnly: false,
          headers: {},
        ),
      ).thenAnswer((_) async => false);

      agent.mockContainer().listen<LaunchUrlState>(
        launchUrlStateProvider,
        (previous, next) {
          stateUrlString = next.urlString;
          stateMode = next.mode;
          stateStatus = next.status;
        },
      );

      final future = agent.mockContainer().read(launcher)(urlString);

      // URL起動前のはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.inAppWebView);
      expect(stateStatus, LaunchUrlStatus.wating);

      await Future.wait([future]);

      // URL起動に失敗したはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.inAppWebView);
      expect(stateStatus, LaunchUrlStatus.error);
    });
  });
}
