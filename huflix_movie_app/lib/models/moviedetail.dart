import 'package:huflix_movie_app/models/genres.dart';

class Movie {
  int? id;
  int? time;
  String? status;
  List<Genre>? genres;
  String? title;
  String? originalTitle;
  String? backdropPath;
  String? posterPath;
  String? overview;
  String? releaseDate;
  double? voteAverage;
  int? voteCount;

  Movie(
      {this.id,
      this.time,
      this.status,
      this.genres,
      this.title,
      this.originalTitle,
      this.backdropPath,
      this.posterPath,
      this.overview,
      this.releaseDate,
      this.voteAverage,
      this.voteCount});

  Movie.fromJson(Map<String, dynamic> json, List<Genre>? genres) {
    id = json["id"];
    time = json["runtime"];
    status = json["status"];
    genres = genres;
    title = json["title"];
    originalTitle = json["original_title"];
    backdropPath = json["backdrop_path"];
    posterPath = json["poster_path"];
    overview = json["overview"];
    releaseDate = json["release_date"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }

  Movie.fromJsonNotGenres(Map<String, dynamic> json) {
    id = json["id"];
    time = json["runtime"];
    status = json["status"];
    title = json["title"];
    genres = [];
    originalTitle = json["original_title"];
    backdropPath = json["backdrop_path"];
    posterPath = json["poster_path"];
    overview = json["overview"];
    releaseDate = json["release_date"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }
}
