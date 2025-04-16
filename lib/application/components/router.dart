part of '../application.dart';

final GoRouter router = GoRouter(
  initialLocation: MovieListPage.path,
  routes: [
    GoRoute(
      path: MovieSearchPage.path,
      name: MovieSearchPage.name,
      builder: (context, state) => const MovieSearchPage(),
    ),
    GoRoute(
      path: '${MovieDetailsPage.path}/:id',
      name: MovieDetailsPage.name,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MovieDetailsPage(movieId: id);
      },
    ),
    GoRoute(
      path: MovieListPage.path,
      name: MovieListPage.name,
      builder: (context, state) => const MovieListPage(),
    ),
  ],
);
