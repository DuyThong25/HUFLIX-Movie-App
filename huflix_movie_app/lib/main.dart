import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api_clients.dart';
import 'package:huflix_movie_app/api/data_sources/movie_remote_data_source.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:http/http.dart' as http;
void main() {
  ApiClient apiClient = ApiClient(http.Client());
  MovieRemoteDataSource dataSource = MovieRemoteDataSourceImpl(apiClient);
  dataSource.getTrending();
  dataSource.getPopular();
  dataSource.getPlayingNow();
  dataSource.getComingSoon();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
      home: HomePage(),
    );
  }
}
