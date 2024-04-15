import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final int movieId;
  final String backdropPath;
  final String title;

  const FavoriteButton({
    required this.movieId,
    required this.backdropPath,
    required this.title,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool favorited =
          await checkIfMovieIsFavorited(user.uid, widget.movieId);
      setState(() {
        isFavorited = favorited;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          if (isFavorited) {
            await removeMovieFromFavorites(user.uid, widget.movieId);
          } else {
            await addMovieToFavorites(
              user.uid,
              widget.movieId,
              widget.backdropPath,
              widget.title,
            );
          }
          setState(() {
            isFavorited = !isFavorited;
          });
        }
      },
      color: isFavorited ? Colors.red : Colors.white,
      iconSize: 38,
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
  
Future<bool> checkIfMovieIsFavorited(String userId, int movieId) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('favorites')
      .doc('$userId-$movieId') 
      .get();
  return snapshot.exists;
}



// Thêm phim vào danh sách yêu thích
Future<void> addMovieToFavorites(String userId, int movieId, String movieBackdrop, String movieTitle) async {
  String documentId = userId + "-"+ movieId.toString();
  await FirebaseFirestore.instance.collection('favorites').doc(documentId).set({
    'userId': userId,
    'movieId': movieId,
    'movieBackdrop': movieBackdrop,
    'movieTitle': movieTitle,
  });
}

// Xoá phim khỏi danh sách yêu thích
Future<void> removeMovieFromFavorites(String userId, int movieId) async {
  String documentId = userId + "-"+ movieId.toString();
  await FirebaseFirestore.instance.collection('favorites').doc(documentId).delete();
}

}
