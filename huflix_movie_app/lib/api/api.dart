import 'dart:convert';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingUrl = "${Constants.BASE_URL}trending/movie/day?api_key=${Constants.API_KEY}&language=vi";
  static const _popularUrl = "${Constants.BASE_URL}movie/popular?api_key=${Constants.API_KEY}&language=vi" ;
  static const _upComingUrl = "${Constants.BASE_URL}movie/upcoming?api_key=${Constants.API_KEY}&language=vi" ;
  static const _nowPlayingUrl = "${Constants.BASE_URL}movie/now_playing?api_key=${Constants.API_KEY}&language=vi" ;

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      print("Phim Trending");
      print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else {
      throw Exception("Có lỗi đang xảy ra" );
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      print("Phim Phổ biến");
      print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upComingUrl));
    if(response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      print("Phim sắp chiếu");
      print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> nowPlayingMovies() async {
    final response = await http.get(Uri.parse(_nowPlayingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      print("Phim đang chiếu");
      print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }
}