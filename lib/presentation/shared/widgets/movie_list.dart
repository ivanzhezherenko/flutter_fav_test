import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/presentation/movie_list_page/widgets/movie_item/movie_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_fav_test/presentation/shared/providers/paginated_movies_provider.dart';

class MovieList extends ConsumerWidget {
  final List<Movie> movies;

  const MovieList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(paginatedMoviesProvider.notifier).isLoading;

    return GridView.builder(
      padding: const EdgeInsets.only(top: 24, left: 16.5, right: 16.5, bottom: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 320,
      ),
      itemCount: movies.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          return const Center(child: CircularProgressIndicator());
        }

        return MovieItem(
          movie: movies[index],
        );
      },
    );
  }
}
