import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  const TabTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        padding: EdgeInsets.only(left: 30, right: 30),
        indicatorWeight: 4,
        // Data title
        tabs: [
          Tab(text: "New"),
          Tab(text: "Trending"),
          Tab(text: "Popular"),
        ],
      ),
    );
  }
}
