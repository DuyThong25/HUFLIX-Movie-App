import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_animated.dart';
import 'package:huflix_movie_app/views/home/movie_tab/Tab_Main.dart';
import 'package:huflix_movie_app/views/drawer/movie_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // backgroundColor: const Color(0x44000000),
          title: const Text("HUFLIX",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white)),
          leading: Builder(
            builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        drawer: MyDrawer(),
        body: const Column(
          children: [
            CarouselAnimated(),
            SizedBox(height: 20),
            Expanded(child: TabMain()),
          ],
        )
      );
  }
}
