import 'dart:async';

import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:flutter_fav_test/domain/network/movie_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieApiProvider = Provider<MovieApiService>((ref) => MovieApiService());

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  final api = ref.read(movieApiProvider);
  return api.getTopRatedMovies();
});

final movieDetailsProvider = FutureProvider.family<Movie, String>((ref, id) async {
  final api = ref.read(movieApiProvider);
  return api.getMovieById(id);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = FutureProvider.autoDispose<List<Movie>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 3) return [];

  await Future.delayed(const Duration(milliseconds: 400));
  final api = ref.read(movieApiProvider);
  return api.searchMovies(query);
});
