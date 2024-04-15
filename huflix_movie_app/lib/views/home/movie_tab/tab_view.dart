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

  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> nowMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowMovies = MyFireStore().getTrendingMoviesFromFirestore();
    upcomingMovies = MyFireStore().getTrendingMoviesFromFirestore();
    popularMovies = MyFireStore().getTrendingMoviesFromFirestore();
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
            // Popular
            FutureBuilder<List<Movie>>(
              future: popularMovies,
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
          ],
        ),
      ),
    );
  }
}
