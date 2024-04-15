// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:intl/intl.dart';

class MyFireStore {
  final db = FirebaseFirestore.instance;

   Future<List<Movie>> getTrendingMoviesFromFirestore() async {
    List<Movie> trendingMovies = [];
    QuerySnapshot querySnapshot = await db.collection("movies")
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
}
