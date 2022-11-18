// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../application/url_launcher/exception/url_launcher_exception.dart';
import '../application/url_launcher/state/url_launch_data.dart';
import '../application/url_launcher/state/url_launch_result.dart';
import '../util/extension.dart';
import '../util/localization/strings.g.dart';
import '../util/logger.dart';
import '../util/routing/router.dart';
import 'theme.dart';

/// GitHubSearch アプリ
class GitHubSearchApp extends StatelessWidget {
  const GitHubSearchApp({
    super.key,
    this.home,
  });

  /// 初期表示画面（テスト用）
  @visibleForTesting
  final Widget? home;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: _GitHubSearchApp(
        home: home,
      ),
    );
  }
}

class _GitHubSearchApp extends ConsumerWidget {
  const _GitHubSearchApp({
    this.home,
  });

  final Widget? home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    // URL起動状態を監視してエラーが起きたらSnackBarを表示する
    // どの画面でURL起動してもここで一括でエラーハンドリングできるようにしている
    ref.listen<AsyncValue<UrlLaunchData?>>(
      urlLaunchResultProvider,
      (previous, next) {
        logger.i('Updated UrlLaunchData: $next');
        next.whenError((error, _) {
          if (error is! UrlLauncherException) {
            return;
          }

          // エラーの場合はSnackBar表示をする
          scaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                i18n.cantLaunchUrl(url: error.data.urlString),
              ),
            ),
          );
        });
      },
    );

    final lightTheme = ref.watch(themeProvider(Brightness.light));
    final darkTheme = ref.watch(themeProvider(Brightness.dark));
    if (home != null) {
      // テスト用
      return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: LocaleSettings.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
        title: 'GitHubSearchTest',
        onGenerateTitle: (context) => i18n.appName,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: home,
        builder: _responsiveWrapperBuilder,
      );
    }

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: LocaleSettings.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      title: 'GitHubSearch',
      onGenerateTitle: (context) => i18n.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.light,
      builder: _responsiveWrapperBuilder,
    );
  }

  Widget _responsiveWrapperBuilder(
    BuildContext context,
    Widget? child,
  ) {
    return ResponsiveWrapper.builder(
      child,
      //    0 ----- AUTOSCALE ----- 320
      //  320 -----   RESIZE  ----- 768(MOBILE)
      //  768 -----   RESIZE  ----- 1024(TABLET)
      // 1024 -----   RESIZE  ----- ∞(DESKTOP)
      breakpoints: [
        const ResponsiveBreakpoint.resize(320, name: MOBILE),
        const ResponsiveBreakpoint.resize(768, name: TABLET),
        const ResponsiveBreakpoint.resize(1024, name: DESKTOP),
      ],
      minWidth: 320,
      maxWidth: 1600,
      defaultScale: true,
      // ignore: use_colored_box
      background: Container(
        color: Theme.of(context).colorScheme.surface,
      ),
      debugLog: !kReleaseMode,
    );
  }
}
