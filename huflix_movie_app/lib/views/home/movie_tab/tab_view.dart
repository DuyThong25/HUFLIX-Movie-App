import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/videotest.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view_data.dart';

class MyTabView extends StatefulWidget {
  const MyTabView({super.key});

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  List<String> listTrending = [];
  List<String> listNew = [];
  List<String> listPopular = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listNew = createDataTest();
    listTrending = createDataTest();
    listPopular = createDataTest();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: Colors.black,
        child: TabBarView(
          children: [
            // New
            TabViewData(listData: listNew),
            // Trending
            TabViewData(listData: listTrending),
            //Poppular
            TabViewData(listData: listPopular),
          ],
        ),
      ),
    );
  }
}
