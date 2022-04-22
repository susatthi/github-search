
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 40 (20.0 per locale)
 *
 * Built on 2022-04-22 at 21:23 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	ja, // 'ja'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of i18n).
///
/// Usage:
/// String a = i18n.someKey.anotherKey;
_StringsEn _i18n = _currLocale.translations;
_StringsEn get i18n => _i18n;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final i18n = Translations.of(context); // Get i18n variable.
/// String a = i18n.someKey.anotherKey; // Use i18n variable.
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_i18n = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();
late _StringsJa _translationsJa = _StringsJa.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.ja: return _translationsJa;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_StringsEn build() {
		switch (this) {
			case AppLocale.en: return _StringsEn.build();
			case AppLocale.ja: return _StringsJa.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.ja: return 'ja';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.ja: return const Locale.fromSubtags(languageCode: 'ja');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'ja': return AppLocale.ja;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build();

	// ignore: unused_field
	late final _StringsEn _root = this;

	// Translations
	String get appName => 'GitHubSearch';
	String get error => 'Error';
	String get errorOccurred => 'An error has occurred.';
	String get forksCount => 'Forks count';
	late final _StringsGitHubExceptionMessageEn gitHubExceptionMessage = _StringsGitHubExceptionMessageEn._(_root);
	String get issuesCount => 'Issues count';
	String get ownerName => 'Owner name';
	String get projectLanguage => 'Project language';
	String get repo => 'Repository';
	String get repoName => 'Repository name';
	String get starsCount => 'Stars count';
	String get searchRepos => 'Search repositories';
	String get watchersCount => 'Watchers count';
}

// Path: gitHubExceptionMessage
class _StringsGitHubExceptionMessageEn {
	_StringsGitHubExceptionMessageEn._(this._root);

	// ignore: unused_field
	final _StringsEn _root;

	// Translations
	String get badRequest => 'Illegal request sent. (400)';
	String get badCredentials => 'Illegal request sent. (401)';
	String get maximumNumberOfLoginAttemptsExceeded => 'Please wait a while and try again. (403)';
	String get notFound => 'No data found. (404)';
	String get validationFailed => 'Illegal request sent. (422)';
	String get serviceUnavailable => 'Please wait a while and try again.  (503)';
	String get unknown => 'An unknown error has occurred. (-1)';
	String get noInternetConnection => 'Please try again in a good communication environment. (-2)';
}

// Path: <root>
class _StringsJa implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsJa.build();

	// ignore: unused_field
	@override late final _StringsJa _root = this;

	// Translations
	@override String get appName => 'GitHubSearch';
	@override String get error => 'エラー';
	@override String get errorOccurred => 'エラーが発生しました。';
	@override String get forksCount => 'Fork数';
	@override late final _StringsGitHubExceptionMessageJa gitHubExceptionMessage = _StringsGitHubExceptionMessageJa._(_root);
	@override String get issuesCount => 'Issue数';
	@override String get ownerName => 'オーナー名';
	@override String get projectLanguage => 'プロジェクト言語';
	@override String get repo => 'リポジトリ';
	@override String get repoName => 'リポジトリ名';
	@override String get starsCount => 'Star数';
	@override String get searchRepos => 'リポジトリを検索';
	@override String get watchersCount => 'Watcher数';
}

// Path: gitHubExceptionMessage
class _StringsGitHubExceptionMessageJa implements _StringsGitHubExceptionMessageEn {
	_StringsGitHubExceptionMessageJa._(this._root);

	// ignore: unused_field
	@override final _StringsJa _root;

	// Translations
	@override String get badRequest => '不正なリクエストが送信されました。(400)';
	@override String get badCredentials => '不正なリクエストが送信されました。(401)';
	@override String get maximumNumberOfLoginAttemptsExceeded => 'しばらく時間をおいてから再度お試しください。(403)';
	@override String get notFound => 'データが見つかりませんでした。(404)';
	@override String get validationFailed => '不正なリクエストが送信されました。(422)';
	@override String get serviceUnavailable => 'しばらく時間をおいてから再度お試しください。(503)';
	@override String get unknown => '不明なエラーが発生しました。(-1)';
	@override String get noInternetConnection => '通信環境の良いところで再度お試しください。(-2)';
}
