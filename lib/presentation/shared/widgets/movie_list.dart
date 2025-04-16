import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/presentation/movie_list_page/widgets/movie_item/movie_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          'assets/icons/empty_state.svg',
          width: 80,
          height: 80,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(top: 24, left: 16.5, right: 16.5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 320,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => MovieItem(
        movie: movies[index],
      ),
    );
  }
}
