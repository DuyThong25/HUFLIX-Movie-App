import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api_clients.dart';
import 'package:huflix_movie_app/api/data_sources/movie_remote_data_source.dart';
import 'package:huflix_movie_app/model/videotest.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view_data.dart';
import 'package:http/http.dart' as http;

class MyTabView extends StatefulWidget {
  const MyTabView({super.key});

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  List<String> listPopular = [];
  List<String> listNow = [];
  List<String> listSoon = [];

  @override
  void initState() {
    super.initState();
    listPopular = createDataTest();
    listNow = createDataTest();
    listSoon = createDataTest();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.black,
        child: TabBarView(
          children: [
            // New
            TabViewData(listData: listPopular),
            // Trending
            TabViewData(listData: listNow),
            //Poppular
            TabViewData(listData: listSoon),
          ],
        ),
      ),
    );
  }
}
