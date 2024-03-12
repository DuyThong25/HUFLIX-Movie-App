import 'dart:convert';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingUrl = "${Constants.BASE_URL}trending/movie/day?api_key=${Constants.API_KEY}&language=vi";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else {
      throw Exception("Có lỗi đang xảy ra" );
    }
  }
}