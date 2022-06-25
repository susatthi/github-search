// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $repoIndexRoute,
    ];

GoRoute get $repoIndexRoute => GoRouteData.$route(
      path: '/repos',
      factory: $RepoIndexRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'search',
          factory: $RepoSearchRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: ':ownerName/:repoName',
          factory: $RepoViewRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'avatar',
              factory: $AvatarPreviewRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $RepoIndexRouteExtension on RepoIndexRoute {
  static RepoIndexRoute _fromState(GoRouterState state) =>
      const RepoIndexRoute();

  String get location => GoRouteData.$location(
        '/repos',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $RepoSearchRouteExtension on RepoSearchRoute {
  static RepoSearchRoute _fromState(GoRouterState state) =>
      const RepoSearchRoute();

  String get location => GoRouteData.$location(
        '/repos/search',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $RepoViewRouteExtension on RepoViewRoute {
  static RepoViewRoute _fromState(GoRouterState state) => RepoViewRoute(
        state.params['ownerName']!,
        state.params['repoName']!,
      );

  String get location => GoRouteData.$location(
        '/repos/${Uri.encodeComponent(ownerName)}/${Uri.encodeComponent(repoName)}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $AvatarPreviewRouteExtension on AvatarPreviewRoute {
  static AvatarPreviewRoute _fromState(GoRouterState state) =>
      AvatarPreviewRoute(
        state.params['ownerName']!,
        state.params['repoName']!,
        $extra: state.extra as Repo?,
      );

  String get location => GoRouteData.$location(
        '/repos/${Uri.encodeComponent(ownerName)}/${Uri.encodeComponent(repoName)}/avatar',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
