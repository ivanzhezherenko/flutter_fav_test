import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/presentation/movie_details_page/widgets/movie_favorite_action.dart';
import 'package:intl/intl.dart';

class MovieDescription extends StatelessWidget {
  final Movie movie;

  const MovieDescription({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final releaseDate = movie.releaseDate;
    final overview = movie.overview;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Rating ${movie.voteAverage.toInt()}',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        if (overview != null)
          Text(
            overview,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        const SizedBox(height: 16),
        if (releaseDate != null)
          Text(
            _formatDate(releaseDate),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        const SizedBox(height: 24),
        MovieFavoriteAction(movie: movie),
      ],
    );
  }

  String _formatDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      return DateFormat('d MMMM y').format(date);
    } catch (e) {
      return rawDate;
    }
  }
}
