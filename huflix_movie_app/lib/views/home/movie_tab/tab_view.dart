import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/models/movie.dart';
import 'package:huflix_movie_app/models/videotest.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view_data.dart';

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
    nowMovies = Api().nowPlayingMovies();
    upcomingMovies = Api().getUpcomingMovies();
    popularMovies = Api().getPopularMovies();
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
                  return CircularProgressIndicator();
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
                  return CircularProgressIndicator();
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
                  return CircularProgressIndicator();
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
