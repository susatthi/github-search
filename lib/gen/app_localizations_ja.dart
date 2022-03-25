


import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'GithubSearch';

  @override
  String get error => 'エラー';

  @override
  String get forksCount => 'Fork数';

  @override
  String get githubApiExceptionMessageBadRequest => '不正なリクエストが送信されました。(400)';

  @override
  String get githubApiExceptionMessageBadCredentials => '不正なリクエストが送信されました。(401)';

  @override
  String get githubApiExceptionMessageMaximumNumberOfLoginAttemptsExceeded => 'しばらく時間をおいてから再度お試しください。(403)';

  @override
  String get githubApiExceptionMessageNotFound => 'データが見つかりませんでした。(404)';

  @override
  String get githubApiExceptionMessageValidationFailed => '不正なリクエストが送信されました。(422)';

  @override
  String get githubApiExceptionMessageServiceUnavailable => 'しばらく時間をおいてから再度お試しください。(503)';

  @override
  String get githubApiExceptionMessageUnknown => '不明なエラーが発生しました。(-1)';

  @override
  String get githubApiExceptionMessageNoInternetConnection => '通信環境の良いところで再度お試しください。(-2)';

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
