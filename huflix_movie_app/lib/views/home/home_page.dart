import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/drawer/movie_drawer.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_animated.dart';
import 'package:huflix_movie_app/views/home/movie_tab/Tab_Main.dart';
import 'package:huflix_movie_app/views/search/search_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // backgroundColor: const Color(0x44000000),
          title: const Text("HUFLIX",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255))),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                color: Colors.white,
                iconSize: 36,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return const SearchMain(isFavoriteWidget: false,);
                      },
                    ) 
                  );
              },
              color: Colors.white,
              iconSize: 36, 
              icon: const Icon(Icons.search))
          ],
        ),
        drawer: const MyDrawer(),
        body: scrwidth < 700
        ? const Column(
          children: [
            Expanded(
              flex: 2,
              child: CarouselAnimated(),
            ),
            // SizedBox(height: 50),
            Expanded(child: TabMain()),
          ],
        ) : Container(
          padding: const EdgeInsets.only(top: 70),
          child: const Row(
          
          children: [
            SizedBox(width: 40),
            Expanded(
              child: CarouselAnimated(),
            ),
            SizedBox(width: 20),
            Expanded(child: TabMain()),
          ],
        ),
        )
        
        );
  }
}
