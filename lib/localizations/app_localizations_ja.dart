


import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'GitHubSearch';

  @override
  String get error => 'エラー';

  @override
  String get errorOccurred => 'エラーが発生しました。';

  @override
  String get forksCount => 'Fork数';

  @override
  String get gitHubExceptionMessageBadRequest => '不正なリクエストが送信されました。(400)';

  @override
  String get gitHubExceptionMessageBadCredentials => '不正なリクエストが送信されました。(401)';

  @override
  String get gitHubExceptionMessageMaximumNumberOfLoginAttemptsExceeded => 'しばらく時間をおいてから再度お試しください。(403)';

  @override
  String get gitHubExceptionMessageNotFound => 'データが見つかりませんでした。(404)';

  @override
  String get gitHubExceptionMessageValidationFailed => '不正なリクエストが送信されました。(422)';

  @override
  String get gitHubExceptionMessageServiceUnavailable => 'しばらく時間をおいてから再度お試しください。(503)';

  @override
  String get gitHubExceptionMessageUnknown => '不明なエラーが発生しました。(-1)';

  @override
  String get gitHubExceptionMessageNoInternetConnection => '通信環境の良いところで再度お試しください。(-2)';

  @override
  String get issuesCount => 'Issue数';

  @override
  String get ownerName => 'オーナー名';

  @override
  String get projectLanguage => 'プロジェクト言語';

  @override
  String get repo => 'リポジトリ';

  @override
  String get repoName => 'リポジトリ名';

  @override
  String get starsCount => 'Star数';

  @override
  String get searchRepos => 'リポジトリを検索';

  @override
  String get watchersCount => 'Watcher数';
}
