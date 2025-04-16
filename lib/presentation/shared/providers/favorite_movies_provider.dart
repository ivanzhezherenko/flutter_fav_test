import 'package:flutter_fav_test/domain/storage/favorite_movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';

final favoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Set<int>>(
  (ref) => FavoriteMoviesNotifier(FavoriteMoviesService())..loadFavorites(),
);

class FavoriteMoviesNotifier extends StateNotifier<Set<int>> {
  final FavoriteMoviesService _service;

  FavoriteMoviesNotifier(this._service) : super(<int>{});

  Future<void> loadFavorites() async {
    final favorites = await _service.loadFavorites();
    state = favorites;
  }

  Future<void> toggle(Movie movie) async {
    await _service.toggleFavorite(movie);
    await loadFavorites();
  }

  bool isFavorite(int id) => state.contains(id);
}
