import 'package:flutter/material.dart';
import 'package:flutter_fav_test/presentation/movie_search_page/widgets/movie_search_input.dart';
import 'package:flutter_fav_test/presentation/shared/providers/movie_search_provider.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_app_bar.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieSearchPage extends ConsumerWidget {
  static const path = '/MovieSearchPage';
  static const name = 'MovieSearchPage';

  const MovieSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(searchMoviesProvider);
    final queryIsNotEmpty = ref.read(searchQueryProvider.notifier).state.isNotEmpty;
    final moviesLength = moviesAsync.whenOrNull(data: (data) => data.length);

    return Scaffold(
      appBar: const MovieAppBar(title: 'Search'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieSearchInput(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
            ),
            const SizedBox(height: 16),
            if (queryIsNotEmpty)
              Text(
                'Search results (${moviesLength ?? '0'})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 16),
            moviesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('$e'),
              data: (movies) {
                return Expanded(
                  child: switch (movies.isEmpty && queryIsNotEmpty) {
                    true => Center(
                        child: SvgPicture.asset(
                          'assets/icons/empty_state.svg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    false => MovieList(movies: movies),
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
