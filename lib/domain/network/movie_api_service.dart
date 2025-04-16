import 'package:flutter_fav_test/domain/models/movie.dart';
import 'package:dio/dio.dart';

class MovieApiService {

  static const _apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NzJkN2U3NWQ1MDJjNzU0MjUwZmNiZTUyYTE4NTQxYyIsIm5iZiI6MTc0NDc1NDI2Ny4zOTEsInN1YiI6IjY3ZmVkNjViZDhiODVlYjc4MmQ5NDE3YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MGWVEtrXoMGa0RnBQPPSXmbN2C7R4mNw0DgWj2vS-CA';


  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization':
            'Bearer $_apiKey',
        'Content-Type': 'application/json;charset=utf-8',
      },
    ),
  );

  static const baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await _dio.get('/movie/top_rated', queryParameters: {
      'language': 'en-US',
      'page': 1,
    });
    final results = response.data['results'] as List;
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  Future<Movie> getMovieById(String id) async {
    final response = await _dio.get('/movie/$id', queryParameters: {
      'language': 'en-US',
    });
    return Movie.fromJson(response.data);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await _dio.get('/search/movie', queryParameters: {
      'query': query,
      'language': 'en-US',
      'page': 1,
    });
    final results = response.data['results'] as List;
    return results.map((json) => Movie.fromJson(json)).toList();
  }
}
