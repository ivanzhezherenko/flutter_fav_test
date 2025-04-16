import 'package:flutter/material.dart';
import 'package:flutter_fav_test/presentation/movie_details_page/widgets/movie_description.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_poster_image.dart';
import 'package:flutter_fav_test/presentation/shared/providers/movie_api_provider.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsPage extends ConsumerWidget {
  final String movieId;

  static const name = 'MovieDetailsPage';
  static const path = '/MovieDetailsPage';

  const MovieDetailsPage({
    required this.movieId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailsProvider(movieId));
    final movieTitle = movieAsync.whenOrNull(data: (movie) => movie.title);

    return Scaffold(
      appBar: MovieAppBar(title: movieTitle),
      body: movieAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
        data: (movie) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: MoviePosterImage(posterPath: movie.posterPath),
              ),
              const SizedBox(height: 8),
              MovieDescription(movie: movie),
            ],
          ),
        ),
      ),
    );
  }
}
