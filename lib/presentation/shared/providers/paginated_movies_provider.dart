import 'package:flutter_fav_test/presentation/shared/providers/movie_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/domain/network/movie_api_service.dart';

final paginatedMoviesProvider =
StateNotifierProvider<PaginatedMoviesNotifier, List<Movie>>(
      (ref) => PaginatedMoviesNotifier(ref.watch(movieApiProvider)),
);

class PaginatedMoviesNotifier extends StateNotifier<List<Movie>> {
  PaginatedMoviesNotifier(this._api) : super([]) {
    loadNextPage();
  }

  final MovieApiService _api;

  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;

  Future<void> loadNextPage() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    final movies = await _api.getTopRatedMovies(page: _currentPage);
    if (movies.isEmpty) {
      _hasMore = false;
    } else {
      _currentPage++;
      state = [...state, ...movies];
    }

    _isLoading = false;
  }

  void refresh() {
    state = [];
    _currentPage = 1;
    _hasMore = true;
    loadNextPage();
  }
}

