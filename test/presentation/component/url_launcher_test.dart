// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/application/url_launcher/state/url_launch_data.dart';
import 'package:github_search/application/url_launcher/state/url_launch_result.dart';
import 'package:github_search/application/url_launcher/url_launcher_service.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../test_util/logger.dart';
import '../../test_util/test_agent.dart';

/// PlatformException を throw する UrlLauncherPlatform
class ErrorkUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {
  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
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

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        true,
      );
    });
    test('不正なURLなら開かないはず（return false）', () async {
      const urlString = 'https://999.168.0.1/';

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        true,
      );
    });
    test('不正なURLなら開かないはず（FormatException）', () async {
      const urlString = 'https://AFEDC:BA98:7654:3210:FEDC:BA98:7654:3210/';

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );
    });

    test('inAppWebView で http or https 以外のスキームのURLなら開かないはず（ArgumentError）',
        () async {
      const urlString = 'mailto:hoge@sample.com';

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString, mode: LaunchMode.inAppWebView);

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );
    });
    test('inAppWebView で空文字なら開かないはず（ArgumentError）', () async {
      const urlString = '';

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );

      await agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString, mode: LaunchMode.inAppWebView);

      expect(
        agent.mockUrlLauncherPlatform.calledUrls.contains(urlString),
        false,
      );
    });
    test('PlatformExceptionがthrowされたらURL起動できないことを監視できるはず', () async {
      const urlString = 'https://github.com';
      String? stateUrlString;
      LaunchMode? stateMode;
      String? status = 'loading';

      agent.mockContainer().listen<AsyncValue<UrlLaunchData?>>(
        urlLaunchResultProvider,
        (previous, next) {
          testLogger.i(next, null, StackTrace.current);
          next.when<void>(
            data: (data) {
              stateUrlString = data?.urlString;
              stateMode = data?.mode;
              status = 'data';
            },
            error: (_, __) {
              stateUrlString = null;
              stateMode = null;
              status = 'error';
            },
            loading: () {
              stateUrlString = null;
              stateMode = null;
              status = 'loading';
            },
          );
        },
      );

      final evacuation = UrlLauncherPlatform.instance;
      UrlLauncherPlatform.instance = ErrorkUrlLauncherPlatform();
      final future = agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);
      UrlLauncherPlatform.instance = evacuation;

      // URL起動前のはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'loading');

      await Future.wait([future]);

      // URL起動に失敗したはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'error');
    });
    test('URL起動できることを監視できるはず', () async {
      const urlString = 'https://github.com';
      String? stateUrlString;
      LaunchMode? stateMode;
      String? status = 'loading';

      agent.mockContainer().listen<AsyncValue<UrlLaunchData?>>(
        urlLaunchResultProvider,
        (previous, next) {
          testLogger.i(next, null, StackTrace.current);
          next.when<void>(
            data: (data) {
              stateUrlString = data?.urlString;
              stateMode = data?.mode;
              status = 'data';
            },
            error: (_, __) {
              stateUrlString = null;
              stateMode = null;
              status = 'error';
            },
            loading: () {
              stateUrlString = null;
              stateMode = null;
              status = 'loading';
            },
          );
        },
      );

      final future = agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);

      // URL起動前のはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'loading');

      await Future.wait([future]);

      // URL起動に成功したはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'data');
    });
    test('URL起動できないことを監視できるはず', () async {
      const urlString = 'https://999.168.0.1/';

      String? stateUrlString;
      LaunchMode? stateMode;
      String? status = 'loading';

      agent.mockUrlLauncherPlatform.launchUrlReturnValue = false;

      agent.mockContainer().listen<AsyncValue<UrlLaunchData?>>(
        urlLaunchResultProvider,
        (previous, next) {
          testLogger.i(next, null, StackTrace.current);
          next.when<void>(
            data: (data) {
              stateUrlString = data?.urlString;
              stateMode = data?.mode;
              status = 'data';
            },
            error: (_, __) {
              stateUrlString = null;
              stateMode = null;
              status = 'error';
            },
            loading: () {
              stateUrlString = null;
              stateMode = null;
              status = 'loading';
            },
          );
        },
      );

      final future = agent
          .mockContainer()
          .read(urlLauncherServiceProvider)
          .launch(urlString);

      // URL起動前のはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'loading');

      await Future.wait([future]);

      // URL起動に失敗したはず
      expect(stateUrlString, urlString);
      expect(stateMode, LaunchMode.platformDefault);
      expect(status, 'error');
    });
  });
}
