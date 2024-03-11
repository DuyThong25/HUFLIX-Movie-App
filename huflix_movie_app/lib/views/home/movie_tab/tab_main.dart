import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_tab/tab_view.dart';

class TabMain extends StatelessWidget {
  const TabMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          // Title of Tab
          Container(
      color: Colors.black,
      child: const TabBar(
        // Custom tab tilte
        dividerColor: Colors.transparent,
        indicatorColor: Colors.purple,
        labelColor: Colors.purple,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        padding: EdgeInsets.only(left: 30, right: 30),
        indicatorWeight: 4,
        // Data title
        tabs: [
          Tab(text: "Phổ biến"),
          Tab(text: "Đang chiếu"),
          Tab(text: "Sắp chiếu"),
        ],
      ),
    ),
          // Tab view data
          const MyTabView(),
        ],
      ),
    );
  }
}
