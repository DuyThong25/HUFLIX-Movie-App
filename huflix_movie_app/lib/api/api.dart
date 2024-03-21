import 'dart:convert';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/models/actordetail.dart';
import 'package:huflix_movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:huflix_movie_app/models/moviedetail.dart';

import '../models/genres.dart';

class Api {
  static const _trendingUrl =
      "${Constants.BASE_URL}trending/movie/day?api_key=${Constants.API_KEY}&language=vi";
  static const _popularUrl =
      "${Constants.BASE_URL}movie/popular?api_key=${Constants.API_KEY}&language=vi";
  static const _upComingUrl =
      "${Constants.BASE_URL}movie/upcoming?api_key=${Constants.API_KEY}&language=vi";
  static const _nowPlayingUrl =
      "${Constants.BASE_URL}movie/now_playing?api_key=${Constants.API_KEY}&language=vi";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim Trending");
      // print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim Phổ biến");
      // print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upComingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim sắp chiếu");
      // print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> nowPlayingMovies() async {
    final response = await http.get(Uri.parse(_nowPlayingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim đang chiếu");
      // print(movieData);
      return movieData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  // Lấy danh sách diễn viên theo id phim
  Future<List<Actor>> actorFindByIdMovie(int idMovie) async {
    String actorUrl =
        "${Constants.BASE_URL}movie/$idMovie/credits?api_key=${Constants.API_KEY}&language=vi";
    final response = await http.get(Uri.parse(actorUrl));
    if (response.statusCode == 200) {
      final actorData = json.decode(response.body)['cast'] as List;
      final crewData = json.decode(response.body)['crew'] as List;

      final combineList = actorData..addAll(crewData);
      // print("Danh sách diễn viên theo $idMovie");
      // print(combineList);

      return combineList.map((actor) => Actor.fromJson(actor)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  // Lấy danh sách diễn viên theo id phim
  Future<List<ActorProfile>> actorInforFindByIdActor(
      List<Actor> crewList) async {
    List<dynamic> combineList = [];
    // Tạo một danh sách các Future để chờ tất cả các yêu cầu hoàn thành
    List<Future> requests = crewList.map((actor) async {
      String personUrl =
          "${Constants.BASE_URL}person/${actor.id}?api_key=${Constants.API_KEY}&language=vi";
      final response = await http.get(Uri.parse(personUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Có lỗi đang xảy ra");
      }
    }).toList();

    // Chờ tất cả các yêu cầu hoàn thành và thêm kết quả vào combineList
    var results = await Future.wait(requests);
    combineList.addAll(results);

    return combineList.map((person) => ActorProfile.fromJson(person)).toList();
  }

  // Lấy thông tin chi tiết của phim
  Future<MovieDetailModel> movieFindById(int idMovie) async {
    String movieDetailUrl =
        "${Constants.BASE_URL}movie/$idMovie?api_key=${Constants.API_KEY}&language=vi";
    final response = await http.get(Uri.parse(movieDetailUrl));
    if (response.statusCode == 200) {
      final movieDetailData = json.decode(response.body);

      final List<dynamic> genresData = movieDetailData['genres'];
      final List<Genre> genres =
          genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();

      return MovieDetailModel(
        id: movieDetailData['id'],
        time: movieDetailData['runtime'],
        status: movieDetailData['status'],
        genres: genres,    
      );
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }
  // Future<List<MovieDetail>> movieFindById(int idMovie) async {
  //   String movieDetailUrl =
  //       "${Constants.BASE_URL}movie/$idMovie?api_key=${Constants.API_KEY}&language=vi";
  //   final response = await http.get(Uri.parse(movieDetailUrl));
  //   if (response.statusCode == 200) {
  //     final tempData = json.decode(response.body);
  //     // print();
  //     final List<dynamic> genresData = tempData['genres'] as List;
  //     final List<Genre> genres = genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();
  //     final movieDetailData = json.decode(response.body) as List;

  //     return movieDetailData.map((movie) => MovieDetail.fromJson(movie, genres)).toList();
  //   } else {
  //     throw Exception("Có lỗi đang xảy ra");
  //   }
  // }
}
