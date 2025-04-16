import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/domain/network/movie_api_service.dart';
import 'package:flutter_fav_test/presentation/movie_details_page/movie_details_page.dart';
import 'package:flutter_fav_test/presentation/shared/widgets/movie_poster_image.dart';
import 'package:flutter_fav_test/presentation/shared/providers/favorite_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieItem extends ConsumerStatefulWidget {
  final Movie movie;

  const MovieItem({
    super.key,
    required this.movie,
  });

  @override
  ConsumerState<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends ConsumerState<MovieItem> {
  final ValueNotifier<bool> _imageLoadedNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _imageLoadedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteMoviesProvider).contains(widget.movie.id);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => context.push('${MovieDetailsPage.path}/${widget.movie.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviePosterImage(
                imageLoadedNotifier: _imageLoadedNotifier,
                posterPath: widget.movie.posterPath,
              ),
              const SizedBox(height: 4),
              Text(
                widget.movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Rating: ${widget.movie.voteAverage.toInt()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _imageLoadedNotifier,
          builder: (context, isLoaded, _) {
            if (!isLoaded) return const SizedBox.shrink();

            return Positioned(
              top: 4,
              right: 8,
              child: IconButton(
                onPressed: () => ref.read(favoriteMoviesProvider.notifier).toggle(widget.movie),
                icon: Icon(
                  Icons.star_rounded,
                  size: 32,
                  color: isFavorite ? const Color(0xFFF2C94C) : const Color(0x66FFFFFF),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
