import 'package:huflix_movie_app/models/genres.dart';

class MovieDetailModel {
  int? id;
  int? time;
  String? status;
  List<Genre>? genres;

  MovieDetailModel({this.id, this.time, this.status, this.genres});

  MovieDetailModel.fromJson(Map<String, dynamic> json, List<Genre>? genres) {
    // final List<dynamic> genresData = json['genres'];
    // final List<Genre> genresList = genresData.map((genreJson) => Genre.fromJson(genreJson)).toList();

    id = json["id"];
    time = json["runtime"];
    status = json["status"];
    genres = genres;
  }
}
