import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesService {
  static const _key = 'favorite_movie_ids';

  Future<Set<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key);

    return ids?.map(int.parse).toSet() ?? <int>{};
  }

  Future<void> toggleFavorite(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await loadFavorites();

    if (current.contains(movie.id)) {
      current.remove(movie.id);
    } else {
      current.add(movie.id);
    }
    await prefs.setStringList(_key, current.map((e) => e.toString()).toList());
  }

  Future<bool> isFavorite(int id) async {
    final current = await loadFavorites();

    return current.contains(id);
  }
}
