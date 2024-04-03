// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/models/actordetail.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/models/trailer.dart';

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
      return movieData.map((movie) {           
          return Movie.fromJsonNotGenres(movie);
        }).toList();
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
      return movieData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  Future<List<Movie>> updateUpcomingMovies(int i) async {
    final response = await http.get(Uri.parse(_upComingUrl));
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim sắp chiếu");
      // print(movieData);
      return movieData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
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
      return movieData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
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
      return movieData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }
    Future<List<Movie>> getAllMovies(int currentPage) async {
        String _allMovieUrl =
        "${Constants.BASE_URL}discover/movie?api_key=${Constants.API_KEY}&language=vi&page=$currentPage&sort_by=popularity.desc&primary_release_year.gte=2020&primary_release_year.lte=2024";
    final response = await http.get(Uri.parse(_allMovieUrl));
    //https://api.themoviedb.org/3/discover/movie?api_key=2f9034d5190d3ecb1c5934d07598fe5c&language=vi&page=20&sort_by=popularity.desc&primary_release_year.gte=2020&primary_release_year.lte=2024
    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      // print("Phim Trending");
      // print(movieData);
      return movieData.map((movie) {           
          return Movie.fromJsonNotGenres(movie);
        }).toList();
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

  // Lấy thông tin diễn viên theo id diễn viên
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
  Future<Movie> movieFindById(int idMovie) async {
    String movieDetailUrl =
        "${Constants.BASE_URL}movie/$idMovie?api_key=${Constants.API_KEY}&language=vi";
    final response = await http.get(Uri.parse(movieDetailUrl));
    if (response.statusCode == 200) {
      final movieDetailData = json.decode(response.body);

      final List<dynamic> genresData = movieDetailData['genres'];
      final List<Genre> genres =
          genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();

      return Movie(
        id: movieDetailData['id'],
        time: movieDetailData['runtime'],
        status: movieDetailData['status'],
        genres: genres,    
      );
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  // Lấy trailer của phim
  Future<Trailer> trailerMovieById(int idMovie) async {
    String trailerMovieUrl = "${Constants.BASE_URL}movie/$idMovie/videos?api_key=${Constants.API_KEY}";
    final response = await http.get(Uri.parse(trailerMovieUrl));
    if (response.statusCode == 200) {
      final Map<String,dynamic> responseData = json.decode(response.body);
      final movie = Trailer.fromJson(responseData);
      for (final result in movie.results!) {
        if (result.type == 'Trailer') { 
          print('Name: ${result.name}');
          print('Key: ${result.key}');
          print('Published At: ${result.publishedAt}');
          print('----------------------------------');
        }
      }
      return Trailer.fromJson(responseData);
    }
    else
    {
      throw Exception('Có lỗi đang xảy ra');
    }
  }

  // Lấy danh sách phim khi tìm kiếm theo tên
   Future<List<Movie>> searchListByName(String inputName) async {
    String searchUrl =
        "${Constants.BASE_URL}search/movie?query=$inputName&include_adult=false&api_key=${Constants.API_KEY}&language=vi&page=1";

    final response = await http.get(Uri.parse(searchUrl));
    if (response.statusCode == 200) {
      final searchData = json.decode(response.body)['results'] as List;

      return searchData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  // Lấy danh sách các phim có cùng thể loại
  Future<List<Movie>> categotyByIDGenres(int idGenres, int currentPage) async {
    String topRateUrl =
        "${Constants.BASE_URL}discover/movie?api_key=${Constants.API_KEY}&language=vi&page=$currentPage&with_genres=$idGenres";
        // https://api.themoviedb.org/3/discover/movie?api_key=2f9034d5190d3ecb1c5934d07598fe5c&language=vi&page=1&with_genres=18
    final response = await http.get(Uri.parse(topRateUrl));
    if (response.statusCode == 200) {
      final resultListData = json.decode(response.body)['results'] as List;
      // final genresData = json.decode(response.body)['results']['genre_ids'];
      // final List<Genre> listGenres = genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();
      
      return resultListData.map((movie) => Movie.fromJsonNotGenres(movie)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }

  // Lấy danh sách tên các thể loại phim
  // Lấy danh sách các phim có cùng thể loại
  Future<List<Genre>> getListGenres() async {
    String getGenresUrl =
        "${Constants.BASE_URL}genre/movie/list?api_key=${Constants.API_KEY}&language=vi";
    //  --url 'https://api.themoviedb.org/3/genre/movie/list?language=vi' \
    final response = await http.get(Uri.parse(getGenresUrl));
    if (response.statusCode == 200) {
      final genresData = json.decode(response.body)['genres'] as List;
      
      return genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();
    } else {
      throw Exception("Có lỗi đang xảy ra");
    }
  }
}
