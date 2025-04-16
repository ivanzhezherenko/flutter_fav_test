import 'package:flutter/material.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_list.dart';
import 'package:flutter_fav_test/presentation/movie_list_page/widgets/movie_list_app_bar.dart';
import 'package:flutter_fav_test/presentation/shared/providers/movie_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListPage extends ConsumerWidget {
  static const name = 'MovieListPage';
  static const path = '/MovieListPage';

  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(topRatedMoviesProvider);

    return Scaffold(
      appBar: const MovieListAppBar(),
      body: moviesAsync.when(
        data: (movies) => MovieList(movies: movies),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Text('$err'),
      ),
    );
  }
}
