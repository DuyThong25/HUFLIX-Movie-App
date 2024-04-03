// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
  int? like;
  int? dislike;

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
      this.voteCount,
      this.like,
      this.dislike
      });

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
    like = json["like"];
    dislike = json["dislike"];
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
    like = json["like"];
    dislike = json["dislike"];
  }

  // Phương thức toJson()
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'status': status,
      'title': title,
      'genres': genres,
      'originalTitle': originalTitle,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
      'overview': overview,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  // Hàm để upload danh sách Movie lên Firestore
  Future<void> uploadMoviesToFirestore() async {
    // List<Movie> movies = await Api().getAllMovies(1);

    // Cập nhật data cho phim
    List<Movie> movies = [];

    for (int i = 1; i <= 20; i++) {
      List<Movie> temps = await Api().getAllMovies(i);
      movies.addAll(temps);
    }

    // Upload từng Movie lên Firestore
    for (Movie movie in movies) {
      Movie movieDetail = await Api().movieFindById(movie.id!);
      String _posterImagePath = Constants.BASE_IMAGE_URL + movie.posterPath!;
      String _backdropImagePath = Constants.BASE_IMAGE_URL + movie.posterPath!;

      movie.status = movieDetail.status;
      movie.time = movieDetail.time;
      movie.posterPath = await uploadImageAndGetDownloadUrl(
          _posterImagePath, "poster_path", movie.id);
      movie.backdropPath = await uploadImageAndGetDownloadUrl(
          _backdropImagePath, "backdrop_path", movie.id);

      // Tạo map với thông tin DateUpdate và Movie
      // Map<String, dynamic> dataToUpload = {
      //   'DateUpdate': DateTime.now(), // Thời gian hiện tại
      //   'Movie': movie.toJson() // Dữ liệu của Movie
      // };

      // Upload dữ liệu lên Firestore
      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.id.toString())
          .set(movie.toJson());
    }
  }

  Future<String> uploadImageAndGetDownloadUrl(String? imageUrl, String storagePath, idMovie) async {
    
    String imageName = basename(imageUrl!);
    // Tạo một tham chiếu đến Firebase Storage
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("ProductImage")
        .child(idMovie.toString())
        .child(storagePath)
        .child(imageName);
    // Bắt đầu tải lên file
    UploadTask uploadTask;
    if (imageUrl == "" || imageUrl.isEmpty) {
      uploadTask = ref.putString("");
    } else {
      uploadTask = ref.putData(await http.readBytes(Uri.parse(imageUrl)));
    }
    // Đợi cho đến khi tải lên hoàn tất
    final snapshot = await uploadTask.whenComplete(() => print("Upload thành công"));

    // Lấy và trả về URL tải xuống
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
