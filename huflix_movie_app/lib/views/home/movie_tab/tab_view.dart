import 'package:flutter/material.dart';
import 'package:huflix_movie_app/firebase/firebase.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view_data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyTabView extends StatefulWidget {
  const MyTabView({super.key});

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  // Stream nó sẽ cập nhật ngay khi dữ liệu thay đổi trên firebase
  late Future<List<Movie>> nowMovies;
  late Future<List<Movie>> upcomingMovies;
  late Stream<List<Movie>> favoriteMovies; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowMovies = MyFireStore().getNowMoviesFromFirestore();
    upcomingMovies = MyFireStore().getUpCommingMoviesFromFirestore();
    favoriteMovies = MyFireStore().getFavoriteMoviesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.black,
        child: TabBarView(
          children: [
            // now
            FutureBuilder<List<Movie>>(
              future: nowMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingAnimationWidget.beat(
                      color: const Color.fromARGB(255, 168, 2, 121), size: 50);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TabViewData(listData: snapshot.data!);
                }
              },
            ),
            // Upcoming
            FutureBuilder<List<Movie>>(
              future: upcomingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingAnimationWidget.beat(
                      color: const Color.fromARGB(255, 168, 2, 121), size: 50);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return TabViewData(listData: snapshot.data!);
                }
              },
            ),
            // Favorites
            // FutureBuilder<List<Movie>>(
            //   future: favoriteMovies,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return LoadingAnimationWidget.beat(
            //       color: const Color.fromARGB(255, 168, 2, 121), size: 50);
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     }else {
            //       if(snapshot.data!.isEmpty) {
            //         return const Center(child: Text("Chưa có phim yêu thích nào.."),);
            //       }else {
            //         return TabViewData(listData: snapshot.data!);
            //       }
            //     }
            //   },
            // ),
            StreamBuilder<List<Movie>>(
              stream: favoriteMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingAnimationWidget.beat(
                      color: const Color.fromARGB(255, 168, 2, 121), size: 50);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Chưa có phim yêu thích nào.."),
                    );
                  } else {
                    return TabViewData(listData: snapshot.data!);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
