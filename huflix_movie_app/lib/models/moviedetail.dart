// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/trailer.dart';
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
  List<Actor>? actors;
  TrailerResult? trailer;

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
      this.dislikeCount,
      this.actors,
      this.trailer});

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
    actors = json["actors"];
    trailer = json["trailer"];
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
    actors = json["actors"];
    trailer = json["trailer"];
  }

  // Phương thức toJson()
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'status': status,
      'title': title,
      'genres': genres?.map((genre) => genre.toJson()).toList(),
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
      'actors':  actors?.map((actor) => actor.toJson()).toList() ,
      'trailer': trailer?.toJson()
    };
  }

  // Hàm để cập nhật phim mới lên fireStore
  Future<void> uploadNewMoviesToFirestore(List<Movie> upComingMovies) async {
    // Cập nhật data cho phim (DONE)
    // List<Movie> upComingMovies = await Api().getAllMovies(1, 2024);

    // Lấy danh sách phim mới cập nhật lên firestore
    // List<Movie> upComingMovies = await Api().updateUpcomingMovies(page, currentYear, currentDate);

    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Code Để update tất cả data trên firestore
/*
  // -----------------------------------------------------------------------------------------------------
    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("movies").get();
    // List<DocumentSnapshot> documents = querySnapshot.docs;
    // for (DocumentSnapshot doc in documents) {
    //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //   if(data.containsKey('actors')) {
    //     print("Movie này đã có actor");
    //   }else {
    //     List<Actor> actorsFindbyMovie = await Api().actorFindByIdMovie(data["id"]); // id movie
    //     actorsFindbyMovie.sort((a, b) {
    //         // đưa "Direction" lên đầu
    //         var jobA = a.department == "Directing" ? 0 : 1;
    //         var jobB = b.department == "Directing" ? 0 : 1;
    //         return jobA.compareTo(jobB);
    //       });
    //     List<Actor> tempActor = [];
    //     int count = 0;
    //     for(Actor actor in actorsFindbyMovie) {
    //       if(count == 20) {break;} // chỉ lấy 20 diễn viên ( actor và direcion )

    //       if(actor.department == "Directing" || actor.department == "Acting") {
    //           Actor detailActor = await Api().actorDetailFindByIdActor(actor.id!);
    //           actor.biography = detailActor.biography;
    //           actor.birthday = detailActor.birthday;
    //           actor.placeOfBirth = detailActor.placeOfBirth;
    //           // Up hình lên
    //           if (actor.profilePath == "" || actor.profilePath == null) {
    //             actor.profilePath = "";
    //           }else {
    //             String _actorImagePath = Constants.BASE_IMAGE_URL + actor.profilePath!;
    //             actor.profilePath = await uploadImageAndGetDownloadUrl(_actorImagePath, "ActorImage", "profile_path", actor.id);
    //           }
    //           tempActor.add(actor);
    //           // Sau đó tạo một collection chứa thông tin của diễn viên
    //           await FirebaseFirestore.instance.collection("actors")
    //           .doc(actor.id.toString())
    //           .set({'actors': actor.toJson()});

    //         count++;
    //       }
    //     }
    //       // Cập nhật các diễn viên vào movie
    //         await FirebaseFirestore.instance.collection("movies")
    //         .doc(doc.id)
    //         .update({'actors': tempActor.map((actor) => actor.toJson()).toList()});

    //     // Cập nhật trailer vào Movie
    //     Api().trailerMovieById(data["id"]).then((trailer) async {
    //       for (final result in trailer.results!) {
    //         if (result.type == 'Trailer') {
    //           // Cập nhật vào movie
    //         await FirebaseFirestore.instance.collection("movies")
    //             .doc(doc.id)
    //             .update({'trailer': result.toJson()});

    //         // Sau đó tạo một collection chứa thông tin của trailer
    //         await FirebaseFirestore.instance.collection("trailer")
    //         .doc(result.resultId.toString())
    //         .set({
    //           'movieID': data["id"],
    //           'movieName': data["title"],
    //           'results': result.toJson()});

    //           break; // Dừng vòng lặp khi tìm thấy trailer đầu tiên
    //         }
    //       }
    //     });
    //   }

    // }

    // -----------------------------------------------------------------------------------------------------
    // Xong rùi thì chuyển thành update cho movie mới
    // chứ không lập qua tất cả phim nữa
*/
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    // Duyệt qua từng movie mới khi lấy từ API xuống
    for (Movie movie in upComingMovies) {
      DocumentSnapshot movieSnapshot = await FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.id.toString()) // Kiểm tra collection trong firestore có phim này chưa
          .get();

      // Cập nhật các chi tiết phim
      Movie movieDetail = await Api().movieFindById(movie.id!);
      movie.genres = movieDetail.genres;
      movie.status = movieDetail.status;
      movie.time = movieDetail.time;

      // Kiểm tra xem phim có tồn tại trong firestore chưa nếu chưa thì set phim lên firestorage
      // Nếu chưa có thì thực hiện lệnh set - có rồi thì update
      if (!movieSnapshot.exists) {
        // Kiểm tra hình ảnh của phim trong API có bị null hay không
        await _checkImageFromAPI(movie);

        // Upload dữ liệu lên Firestore
        await FirebaseFirestore.instance
            .collection('movies')
            .doc(movie.id.toString())
            .set(movie.toJson());

        // Sau khi thêm phim vào Collection thì:

        // Cập nhật danh sách Actors
        await _updateActorData(movie.id);

        // Cập nhật Trailer
        await _updateTrailerData(movie.id, movie.title);
      } else {
        print('Bộ phim đã tồn tại trong Firestore');

        Map<String, dynamic> data =movieSnapshot.data() as Map<String, dynamic>;

        // Kiểm tra field Actor trong Movie có dữ liệu chưa
        if (data['actors'] == null || data['actors'] == "") {
          await _updateActorData(movie.id);
        } else {
          var actorsList = data['actors'] as List;
          movie.actors = actorsList
              .map((actorJson) => Actor.fromJsonForFirebase(actorJson))
              .toList();
        }
        // Kiểm tra field Trailer trong Movie có dữ liệu chưa
        if (data['trailer'] == null || data['trailer'] == "") {
          await _updateTrailerData(movie.id, movie.title);
        } else {
          var trailerResult = data['trailer'];
          movie.trailer = TrailerResult.fromJsonForFirebase(trailerResult);
        }
        // Cập nhật số like và dislike
        movie.dislikeCount = data['dislikeCount'];
        movie.likeCount = data['likeCount'];

        // Kiểm tra hình ảnh trong firestore
        await _checkImageFromFirestore(data, movie);

        await FirebaseFirestore.instance
            .collection('movies')
            .doc(movie.id.toString())
            .update(movie.toJson());
      }
    }
  }

  Future<void> _checkImageFromFirestore(
      Map<String, dynamic> data, Movie movie) async {
    // Nếu phim đã tồn tại rồi thì kiểm tra xem dữ liệu trong hình ảnh trong fire store có bị null không
    // Nếu NULL thì kiểm tra đối chiếu với link API
    // Nếu link API cũng null thì tiếp tục trả về null nếu không thì cập nhật hình ảnh lên

    try {
      if (data['backdropPath'] == null ||
          data['backdropPath'] == "" ||
          !data['backdropPath'].toString().contains('https')) {
        // Kiểm tra data trên firebase
        if (movie.backdropPath != null || movie.backdropPath != "") {
          // Kiểm tra data trên API
          String _backdropImagePath =
              Constants.BASE_IMAGE_URL + movie.backdropPath!;
          movie.backdropPath = await _uploadImageAndGetDownloadUrl(
              _backdropImagePath, "ProductImage", "backdrop_path", movie.id);
        }
      }
      if (data['posterPath'] == null ||
          data['posterPath'] == "" ||
          !data['posterPath'].toString().contains('https')) {
        // Kiểm tra data trên firebase
        if (movie.posterPath != null || movie.posterPath != "") {
          // Kiểm tra data trên API
          String _posterImagePath =
              Constants.BASE_IMAGE_URL + movie.posterPath!;
          movie.posterPath = await _uploadImageAndGetDownloadUrl(
              _posterImagePath, "ProductImage", "poster_path", movie.id);
        }
      }
    } catch (e) {
      print("Lỗi: ${e.toString()}");
    }
  }

  Future<void> _checkImageFromAPI(Movie movie) async {
    try {
      if (movie.posterPath == null || movie.posterPath == "") {
        movie.posterPath = "";
      } else {
        String _posterImagePath = Constants.BASE_IMAGE_URL + movie.posterPath!;
        movie.posterPath = await _uploadImageAndGetDownloadUrl(
            _posterImagePath, "ProductImage", "poster_path", movie.id);
      }
      if (movie.backdropPath == null || movie.backdropPath == "") {
        movie.backdropPath = "";
      } else {
        String _backdropImagePath =
            Constants.BASE_IMAGE_URL + movie.backdropPath!;
        movie.backdropPath = await _uploadImageAndGetDownloadUrl(
            _backdropImagePath, "ProductImage", "backdrop_path", movie.id);
      }
    } catch (e) {
      print("Lỗi: ${e.toString()}");
    }
  }

  Future<String> _uploadImageAndGetDownloadUrl(
      String? imageUrl, String storageName, String storagePath, id) async {

    if (imageUrl == null || imageUrl.isEmpty) {
      return "";
    }
    try {
      String imageName = basename(imageUrl);
      // Tạo một tham chiếu đến Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(storageName)
          .child(id.toString())
          .child(storagePath)
          .child(imageName);
      // Bắt đầu tải lên file
      UploadTask uploadTask =
          ref.putData(await http.readBytes(Uri.parse(imageUrl)));

      // Đợi cho đến khi tải lên hoàn tất và lấy URL tải xuống
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Xử lý ngoại lệ nếu có
      print('Đã xảy ra lỗi khi tải lên: $e');
      return "";
    }
  }

  Future<void> _updateActorData(idMovie) async {
    try {
      List<Actor> actorsFindbyMovie =
          await Api().actorFindByIdMovie(idMovie); // id movie

      if (actorsFindbyMovie.isNotEmpty) {
        actorsFindbyMovie.sort((a, b) {
          // đưa "Direction" lên đầu
          var jobA = a.department == "Directing" ? 0 : 1;
          var jobB = b.department == "Directing" ? 0 : 1;
          return jobA.compareTo(jobB);
        });
        List<Actor> tempActor = [];
        int count = 0;
        for (Actor actor in actorsFindbyMovie) {
          if (count == 20) {
            break;
          } // chỉ lấy 20 diễn viên ( actor và direcion )

          if (actor.department == "Directing" || actor.department == "Acting") {
            Actor detailActor = await Api().actorDetailFindByIdActor(actor.id!);
            actor.biography = detailActor.biography;
            actor.birthday = detailActor.birthday;
            actor.placeOfBirth = detailActor.placeOfBirth;
            // Up hình lên
            if (actor.profilePath == "" || actor.profilePath == null) {
              actor.profilePath = "";
            } else {
              String _actorImagePath =
                  Constants.BASE_IMAGE_URL + actor.profilePath!;
              actor.profilePath = await _uploadImageAndGetDownloadUrl(
                  _actorImagePath, "ActorImage", "profile_path", actor.id);
            }
            tempActor.add(actor);
            // Tạo một collection chứa thông tin của diễn viên
            await FirebaseFirestore.instance
                .collection("actors")
                .doc(actor.id.toString())
                .set({'actors': actor.toJson()});

            count++;
          }
        }
        // Cập nhật các diễn viên vào movie
        await FirebaseFirestore.instance
            .collection("movies")
            .doc(idMovie.toString())
            .update(
                {'actors': tempActor.map((actor) => actor.toJson()).toList()});
      } else {
        //  actor = null nếu không tìm thấy danh sách actor từ API
        await FirebaseFirestore.instance
            .collection("movies")
            .doc(idMovie.toString())
            .update({'actors': null});
      }
    } catch (e) {
      print("Lỗi: ${e.toString()}");
    }
  }

  Future<void> _updateTrailerData(idMovie, nameMovie) async {
    try {
      // Cập nhật trailer vào Movie
      Api().trailerMovieById(idMovie).then((trailer) async {
        bool _isValid = false;
        if (trailer.results!.isNotEmpty) {
          for (final result in trailer.results!) {
            if (result.type == 'Trailer' || result.type == 'Teaser') {
              _isValid = true;
              // Cập nhật vào movie
              await FirebaseFirestore.instance
                  .collection("movies")
                  .doc(idMovie.toString())
                  .update({'trailer': result.toJson()});

              // Sau đó tạo một collection chứa thông tin của trailer
              await FirebaseFirestore.instance
                  .collection("trailer")
                  .doc(result.resultId.toString())
                  .set({
                'movieID': idMovie,
                'movieName': nameMovie,
                'results': result.toJson()
              });
              break; // Dừng vòng lặp khi tìm thấy trailer đầu tiên
            }
          }
        }

        // Nếu không tìm thấy trailer nào phù hợp thì thêm vào movie field 'trailer' có giá trị là null
        if (_isValid == false) {
          await FirebaseFirestore.instance
              .collection("movies")
              .doc(idMovie.toString())
              .update({'trailer': null});
        }
      });
    } catch (e) {
      print("Lỗi: ${e.toString()}");
    }
  }
}
