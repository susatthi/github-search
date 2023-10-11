// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $repoIndexRoute,
    ];

RouteBase get $repoIndexRoute => GoRouteData.$route(
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

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $RepoSearchRouteExtension on RepoSearchRoute {
  static RepoSearchRoute _fromState(GoRouterState state) =>
      const RepoSearchRoute();

  String get location => GoRouteData.$location(
        '/repos/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $RepoViewRouteExtension on RepoViewRoute {
  static RepoViewRoute _fromState(GoRouterState state) => RepoViewRoute(
        state.params['ownerName']!,
        state.params['repoName']!,
      );

  String get location => GoRouteData.$location(
        '/repos/${Uri.encodeComponent(ownerName)}/${Uri.encodeComponent(repoName)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
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

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);
}
