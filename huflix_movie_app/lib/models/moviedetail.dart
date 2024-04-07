// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:path/path.dart';

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
  double? popularity;
  int? voteCount;
  int? likeCount;
  int? dislikeCount;

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
      this.popularity,
      this.voteCount,
      this.likeCount,
      this.dislikeCount});
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
    popularity = json["popularity"];
    voteCount = json["vote_count"];
    likeCount = json["like"];
    dislikeCount = json["dislike"];
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
    popularity = json["popularity"];
    voteCount = json["vote_count"];
    likeCount = json["like"];
    dislikeCount = json["dislike"];
  }

  // Phương thức toJson()
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'status': status,
      'title': title,
      'genres': genres!.map((genre) => genre.toJson()).toList(),
      'originalTitle': originalTitle,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
      'overview': overview,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'popularity': popularity,
      'voteCount': voteCount,
      'likeCount': likeCount,
      'dislikeCount': dislikeCount,
    };
  }

  // Hàm để cập nhật phim mới lên fireStore
  Future<void> uploadNewMoviesToFirestore(List<Movie> upComingMovies) async {
    // Cập nhật data cho phim (DONE)
    // List<Movie> upComingMovies = await Api().getAllMovies(1, 2024);

    // Lấy danh sách phim mới cập nhật lên firestore
    // List<Movie> upComingMovies = await Api().updateUpcomingMovies(page, currentYear, currentDate);

    // Upload từng Movie lên Firestore
    for (Movie movie in upComingMovies) {
      // Kiểm tra xem bộ phim đã tồn tại trong Firestore chưa
      DocumentSnapshot movieSnapshot = await FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.id.toString())
          .get();   
      // Cập nhật các chi tiết phim
      Movie movieDetail = await Api().movieFindById(movie.id!);
      movie.genres = movieDetail.genres;
      movie.status = movieDetail.status;
      movie.time = movieDetail.time;

      // Kiểm tra xem phim có tồn tại chưa nếu chưa thì set phim lên firestorage
      // Nếu có rồi thì thực hiện lệnh update
      if (!movieSnapshot.exists) {
        // Kiểm tra hình ảnh của phim trong API có bị null hay không
        if (movie.posterPath == null || movie.posterPath == "") {
          movie.posterPath = "";
        } else {
          String _posterImagePath = Constants.BASE_IMAGE_URL + movie.posterPath!;
          movie.posterPath = await uploadImageAndGetDownloadUrl(_posterImagePath, "poster_path", movie.id);
        }
        if (movie.backdropPath == null || movie.backdropPath == "") {
          movie.backdropPath = "";
        } else {
          String _backdropImagePath =
              Constants.BASE_IMAGE_URL + movie.backdropPath!;
          movie.backdropPath = await uploadImageAndGetDownloadUrl(
              _backdropImagePath, "backdrop_path", movie.id);
        }
        // Upload dữ liệu lên Firestore
        await FirebaseFirestore.instance
            .collection('movies')
            .doc(movie.id.toString())
            .set(movie.toJson());
      } else {
        print('Bộ phim đã tồn tại trong Firestore');
        // Nếu phim đã tồn tại rồi thì kiểm tra xem dữ liệu trong hình ảnh trong fire store có bị null không
        // Nếu NULL thì kiểm tra đối chiếu với link API
        // Nếu link API cũng null thì tiếp tục trả về null nếu không thì cập nhật hình ảnh lên
        Map<String, dynamic> data = movieSnapshot.data() as Map<String, dynamic>;
        if(data['backdropPath'] == null || data['backdropPath'] == "") {
          if (movie.backdropPath != null || movie.backdropPath != "") {
            String _backdropImagePath = Constants.BASE_IMAGE_URL + movie.backdropPath!;
            movie.backdropPath = await uploadImageAndGetDownloadUrl(_backdropImagePath, "backdrop_path", movie.id);
          }
        }
        if(data['posterPath'] == null || data['posterPath'] == "") {
          if (movie.posterPath != null || movie.posterPath != "") {
            String _posterImagePath = Constants.BASE_IMAGE_URL + movie.posterPath!;
            movie.posterPath = await uploadImageAndGetDownloadUrl(_posterImagePath, "poster_path", movie.id);
          }
        }
        await FirebaseFirestore.instance
            .collection('movies')
            .doc(movie.id.toString())
            .update(movie.toJson());
      }
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
    UploadTask uploadTask = ref.putData(await http.readBytes(Uri.parse(imageUrl)));

    // Đợi cho đến khi tải lên hoàn tất
    final snapshot = await uploadTask.whenComplete(() => print("Upload thành công"));

    // Lấy và trả về URL tải xuống
    String downloadUrl = (imageUrl == "" || imageUrl.isEmpty)
        ? ""
        : await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
