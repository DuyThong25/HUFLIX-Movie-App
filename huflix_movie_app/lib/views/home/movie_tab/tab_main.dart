import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_title.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view.dart';

class TabMain extends StatelessWidget {
  const TabMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          // Title of Tab
          TabTitle(),
          // Tab view data
          MyTabView(),
        ],
      ),
    );
  }
}
