import 'package:huflix_movie_app/api/api_clients.dart';
import 'package:huflix_movie_app/model/movie_model.dart';
import 'package:huflix_movie_app/model/movie_result.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending(); // gọi API, danh sách phim trending theo ngày
  Future<List<MovieModel>> getPopular(); // gọi API, danh sách phim phổ biến 
  Future<List<MovieModel>> getPlayingNow(); // gọi API, danh sách phim đang chiếu
  Future<List<MovieModel>> getComingSoon(); // gọi API, danh sách phim sắp chiếu

}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;
  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {  
      final response = await _client.get('trending/movie/day');
      final movies = MoviesResultModel.fromJson(response).movies;
      print('\x1B[38;5;31mPhim trending\x1B[0m');
      print(movies);
      return movies ?? [];
  }

  @override
  Future<List<MovieModel>> getPopular() async {
      final response = await _client.get('movie/popular');
      final movies = MoviesResultModel.fromJson(response).movies;
      print('\x1B[38;5;31mPhim phổ biến\x1B[0m');
      print(movies);
      return movies ?? [];
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
      final response = await _client.get('movie/upcoming');
      final movies = MoviesResultModel.fromJson(response).movies;
      print('\x1B[38;5;31mPhim sắp chiếu\x1B[0m');
      print(movies);
      return movies ?? [];
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
      final response = await _client.get('movie/now_playing');
      final movies = MoviesResultModel.fromJson(response).movies;
      print('\x1B[38;5;31mPhim đang chiếu\x1B[0m');
      print(movies);
      return movies ?? [];
  }
}