// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/localizations/strings.g.dart';
import '../utils/logger.dart';
import '../utils/routing/router.dart';
import 'components/theme.dart';
import 'components/url_launcher.dart';

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
    ref.listen<UrlLauncherState>(
      urlLauncherStateProvider,
      (previous, next) {
        logger.i(
          'Changed LaunchUrlState: '
          'status = ${next.status.name}, url = ${next.urlString}',
        );
        if (next.status == UrlLauncherStatus.error) {
          // エラーの場合はSnackBar表示をする
          scaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(i18n.cantLaunchUrl(url: next.urlString!)),
            ),
          );
        }
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
        builder: responsiveWrapperBuilder,
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
    );
  }
}
