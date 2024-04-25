// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/models/user.dart';

class MyFireStore {
  final db = FirebaseFirestore.instance;

  Future<List<Movie>> getTrendingMoviesFromFirestore() async {
    List<Movie> trendingMovies = [];
    QuerySnapshot querySnapshot = await db
        .collection("movies")
        .limit(20)
        .orderBy("popularity", descending: true)
        .orderBy("releaseDate", descending: true)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      trendingMovies.add(Movie.fromFirestore(data));
    }
    print("Successfully completed");
    return trendingMovies;
  }

  Future<List<Movie>> getUpCommingMoviesFromFirestore() async {
    List<Movie> upcommingMovies = [];
    QuerySnapshot querySnapshot = await db
        .collection("movies")
        .limit(20)
        .where("status", isNotEqualTo: "Released")
        .orderBy("status", descending: true)
        .orderBy("popularity", descending: true)
        .orderBy("releaseDate", descending: true)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      upcommingMovies.add(Movie.fromFirestore(data));
    }
    print("Successfully completed");
    return upcommingMovies;
  }

  Future<List<Movie>> getNowMoviesFromFirestore() async {
    List<Movie> upcommingMovies = [];
    QuerySnapshot querySnapshot = await db
        .collection("movies")
        .limit(20)
        .where("status", isEqualTo: "Released")
        .orderBy("popularity", descending: true)
        .orderBy("releaseDate", descending: true)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      upcommingMovies.add(Movie.fromFirestore(data));
    }
    print("Successfully completed");
    return upcommingMovies;
  }

  Stream<List<Movie>> getFavoriteMoviesFromFirestore() {
    final currentUser = User().getCurrentUser();
    return db
        .collection("favorites")
        .where("userId", isEqualTo: currentUser.uid)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<Movie> favoriteMovies = [];
      for (var docSnapshot in querySnapshot.docs) {
        final dataFavorite = docSnapshot.data() as Map<String, dynamic>;
        // Lấy ra movie id
        var movieId = dataFavorite['movieId'];
        // Query thông tin chi tiết của phim từ collection "movies"
        var movieSnapshot =
            await db.collection("movies").where("id", isEqualTo: movieId).get();
        // Thêm phim vào danh sách yêu thích
        if (movieSnapshot.docs.isNotEmpty) {
          final dataMovie =
              movieSnapshot.docs.first.data() as Map<String, dynamic>;
          favoriteMovies.add(Movie.fromFirestore(dataMovie));
        }
      }
      return favoriteMovies;
    });
  }

  Future<List<Movie>> getFavoriteMoviesFromFirestore_FutureBuilder() async {
    final currentUser = User().getCurrentUser();
    List<Movie> favoriteMovies = [];
    QuerySnapshot querySnapshot = await db
        .collection("favorites")
        .where("userId", isEqualTo: currentUser.uid)
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      final dataFavorite = docSnapshot.data() as Map<String, dynamic>;
      // Lấy ra movie id
      var movieId = dataFavorite['movieId'];
      // Query thông tin chi tiết của phim từ collection "movies"
      var movieSnapshot =
          await db.collection("movies").where("id", isEqualTo: movieId).get();
      // Thêm phim vào danh sách yêu thích
      if (movieSnapshot.docs.isNotEmpty) {
        final dataMovie =
            movieSnapshot.docs.first.data() as Map<String, dynamic>;
        favoriteMovies.add(Movie.fromFirestore(dataMovie));
      }
    }
    print("Successfully completed");
    return favoriteMovies;
  }

  Future<List<Movie>> getMoviesByNameFromFirestore(
      String input, bool isFavorite) async {
    List<Movie> searchMovies = [];
    // format input
    String formatInput = input.split(' ').map((str) {
      // Kiểm tra nếu từ rỗng
      if (str.isEmpty) {
        return '';
      }
      // Chỉ viết hoa chữ cái đầu nếu từ không rỗng
      return str[0].toUpperCase() + str.substring(1).toLowerCase();
    }).join(' ');
    QuerySnapshot querySnapshot;

    if (isFavorite == false) {
      querySnapshot = await db
          .collection("movies")
          .where(
            "title",
            isGreaterThanOrEqualTo: formatInput,
          )
          .limit(10)
          .get();
      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        searchMovies.add(Movie.fromFirestore(data));
      }
    } else {
      final currentUser = User().getCurrentUser();
      querySnapshot = await db
          .collection("favorites")
          .where("userId", isEqualTo: currentUser.uid)
          .where(
            "movieTitle",
            isGreaterThanOrEqualTo: formatInput,
          )
          .get();
      for (var docSnapshot in querySnapshot.docs) {
        final dataFavorite = docSnapshot.data() as Map<String, dynamic>;
        // Lấy ra movie id
        var movieId = dataFavorite['movieId'];
        // Query thông tin chi tiết của phim từ collection "movies"
        var movieSnapshot =
            await db.collection("movies").where("id", isEqualTo: movieId).get();
        // Thêm phim vào danh sách yêu thích
        if (movieSnapshot.docs.isNotEmpty) {
          final dataMovie =
              movieSnapshot.docs.first.data() as Map<String, dynamic>;
          searchMovies.add(Movie.fromFirestore(dataMovie));
        }
      }
    }

    print("Successfully completed");
    return searchMovies;
  }

  Future<List<Movie>> getTop10LikeFromFirestore() async {
    List<Movie> mostLikeMovies = [];
    QuerySnapshot querySnapshot = await db
        .collection("movies")
        .limit(10)
        .orderBy("likeCount", descending: true)
        .orderBy("dislikeCount")
        .get();

    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      mostLikeMovies.add(Movie.fromFirestore(data));
    }
    print("Successfully completed");
    return mostLikeMovies;
  }
}
