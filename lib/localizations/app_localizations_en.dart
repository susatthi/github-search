


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'GithubSearch';

  @override
  String get error => 'Error';

  @override
  String get errorOccurred => 'An error has occurred.';

  @override
  String get forksCount => 'Forks count';

  @override
  String get githubApiExceptionMessageBadRequest => 'Illegal request sent. (400)';

  @override
  String get githubApiExceptionMessageBadCredentials => 'Illegal request sent. (401)';

  @override
  String get githubApiExceptionMessageMaximumNumberOfLoginAttemptsExceeded => 'Please wait a while and try again. (403)';

  @override
  String get githubApiExceptionMessageNotFound => 'No data found. (404)';

  @override
  String get githubApiExceptionMessageValidationFailed => 'Illegal request sent. (422)';

  @override
  String get githubApiExceptionMessageServiceUnavailable => 'Please wait a while and try again.  (503)';

  @override
  String get githubApiExceptionMessageUnknown => 'An unknown error has occurred. (-1)';

  @override
  String get githubApiExceptionMessageNoInternetConnection => 'Please try again in a good communication environment. (-2)';

  @override
  String get issuesCount => 'Issues count';

  @override
  String get ownerName => 'Owner name';

  @override
  String get projectLanguage => 'Project language';

  @override
  String get repo => 'Repository';

  @override
  String get repoName => 'Repository name';

  @override
  String get starsCount => 'Stars count';

  @override
  String get searchRepos => 'Search repositories';

  @override
  String get watchersCount => 'Watchers count';
}
