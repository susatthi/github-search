// Copyright 2022 susatthi All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localizations/strings.g.dart';
import '../utils/assets/fonts.gen.dart';
import 'router.dart';

/// GitHubSearch アプリ
class GitHubSearchApp extends StatelessWidget {
  const GitHubSearchApp({
    Key? key,
    this.home,
  }) : super(key: key);

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
    Key? key,
    this.home,
  }) : super(key: key);

  final Widget? home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: FontFamily.murecho,
    );
    if (home != null) {
      // テスト用
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: LocaleSettings.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
        title: 'GitHubSearchTest',
        onGenerateTitle: (context) => i18n.appName,
        theme: theme,
        home: home,
      );
    }

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: LocaleSettings.supportedLocales,
      locale: TranslationProvider.of(context).flutterLocale,
      title: 'GitHubSearch',
      onGenerateTitle: (context) => i18n.appName,
      theme: theme,
    );
  }
}
