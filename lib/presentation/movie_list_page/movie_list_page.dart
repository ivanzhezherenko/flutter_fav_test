import 'package:flutter/material.dart';
import 'package:flutter_fav_test/presentation/movie_list_page/widgets/movie_list_app_bar.dart';
import 'package:flutter_fav_test/presentation/shared/providers/paginated_movies_provider.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListPage extends ConsumerWidget {
  static const name = 'MovieListPage';
  static const path = '/MovieListPage';

  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(paginatedMoviesProvider);
    final notifier = ref.read(paginatedMoviesProvider.notifier);

    return Scaffold(
      appBar: const MovieListAppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
            notifier.loadNextPage();
          }
          return false;
        },
        child: MovieList(movies: movies),
      ),
    );
  }
}
