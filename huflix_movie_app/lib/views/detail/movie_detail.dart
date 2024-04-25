// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/common/common.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/detail/favorite_button.dart';
import 'package:huflix_movie_app/views/detail/movie_detail_description.dart';
import 'package:huflix_movie_app/views/detail/movie_detail_infor.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_backdrop.dart';
import 'package:intl/intl.dart';
import 'movie_detail_actor.dart';
import 'movie_statusbar.dart';

class MovieDetailMain extends StatelessWidget {
  MovieDetailMain({super.key, required this.movie});

  final Movie movie;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.white,
              icon: const Icon(Icons.keyboard_backspace_sharp),
              iconSize: 38,
              onPressed: () {
                
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        actions: [
          FavoriteButton(
            movieId: movie.id!,
            backdropPath: movie.backdropPath!,
            title: movie.title!,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Poster của phim
            scrwidth < 700
                ? // giao diện màn hình dọc
                Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 320,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: movie.posterPath != null
                                ? Image.network(
                                    movie.posterPath!,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/images/logo1.jpg",
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topCenter,
                                    ),
                                  )
                                : Image.asset(
                                    "assets/images/logo1.jpg",
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                  ),
                          )),
                      // status bar - Fuunction Bar
                      Positioned(
                          bottom: 14,
                          left: 65,
                          right: 65,
                          child: StatusBarDetail(
                              idMovie: movie.id!, trailerResult: movie.trailer))
                    ],
                  )
                : //giao diện màn hình ngang
                Stack(
                    children: [
                      CarouselBackdrop(
                        src: movie.backdropPath!,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          width: MediaQuery.of(context).size.width - 600,
                          height: MediaQuery.of(context).size.height,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: movie.posterPath != null
                                ? Image.network(
                                    movie.posterPath!,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      "assets/images/logo1.jpg",
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topCenter,
                                  )
                                )
                                : Image.asset(
                                    "assets/images/logo1.jpg",
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                  ),
                          ),
                        ),
                      ),
                      // status bar - Fuunction Bar
                      Positioned(
                        bottom: 30,
                        left: 65,
                        right: 65,
                        child: StatusBarDetail(
                          idMovie: movie.id!,
                          trailerResult: movie.trailer,
                        ),
                      ),
                    ],
                  ),
            // Container chứa Nội dung của movie detail
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Infor bar
                  InforMovie(
                    movie: movie,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // Description of the movie
                  MovieDetalDescription(description: movie.overview!),
                  Divider(
                    color: Colors.grey[900],
                    height: 22,
                  ),
                  // List Actor và Crew
                  const Text(
                    "Diễn viên",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  MovieDetailActor(actorOfMovie: movie.actors!),
                  _buildCommentSection(context),
                  //   Container(
                  // height: MediaQuery.of(context).size.height,
                  //     width: MediaQuery.of(context).size.width,
                  //     // height: MediaQuery.of(context).size.height,
                  //     color: Colors.green,
                  //   ),
                ],
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   color: Colors.green,
            // ),
          ],
        ),
      ),
    );
  }

// Define the function
  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "${hours}g${minutes}p";
  }

  // Widget để hiển thị phần comment
  Widget _buildCommentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Bình luận',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        // Widget để hiển thị danh sách các comment
        _buildCommentList(context),
        // Widget để hiển thị form để người dùng nhập comment
        _buildCommentForm(context),
      ],
    );
  }

  Widget _buildCommentList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('movieId', isEqualTo: movie.id)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          print("$snapshot.error");
          return Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('Hiện tại chưa có bình luận nào',
              style: TextStyle(color: Colors.white));
        }

        return Container(
          height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final commentData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              if (commentData['timestamp'] != null) {
                String formattedDate = DateFormat('dd/MM/yyyy - HH:mm:ss')
                    .format(commentData['timestamp'].toDate());
                return ListTile(
                  title: Text(
                      Common.shortenStringChar(commentData['email'], 18),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 123, 34),
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(commentData['text'].toString(),
                      style: const TextStyle(color: Colors.white)),
                  trailing: Text(formattedDate,
                      style: TextStyle(color: Colors.grey[500])),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }

  // Widget để hiển thị form nhập comment
  Widget _buildCommentForm(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Nhập bình luận",
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.redAccent[700],
                  ),
                  onPressed: () {
                    _submitComment(_commentController.text, context);
                    _commentController.clear();
                  },
                ),
              ),
              onTap: () {
                _scrollToBottom();
              },
            )));
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  // Hàm để gửi comment lên Firestore
  void _submitComment(String commentText, BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final username = user.displayName ?? user.email ?? 'Unknown';
      final commentData = {
        'text': commentText,
        'userId': user.uid,
        'username': username,
        'email': user.email,
        'movieId': movie.id,
        'movieName': movie.title,
        'timestamp': FieldValue.serverTimestamp(),
      };
      await FirebaseFirestore.instance.collection('comments').add(commentData);
    } else {
      // Đưa ra thông báo yêu cầu người dùng đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng đăng nhập để bình luận'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
