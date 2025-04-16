import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/presentation/shared/providers/favorite_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieFavoriteAction extends ConsumerWidget {
  final Movie movie;

  const MovieFavoriteAction({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteMoviesProvider).contains(movie.id);
    final (borderColor, textColor, bgColor) = _getColors(context, isFavorite);

    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => ref.read(favoriteMoviesProvider.notifier).toggle(movie),
      child: Container(
        height: 47,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          switch (isFavorite) {
            true => 'Remove from favorites',
            false => 'Add to favorites',
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  (Color border, Color text, Color background) _getColors(BuildContext context, bool isFavorite) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (isFavorite) {
      true => (colorScheme.onSurface, colorScheme.onSurface, Colors.transparent),
      false => (Colors.transparent, Colors.black, const Color(0xFFF2C94C)),
    };
  }
}
