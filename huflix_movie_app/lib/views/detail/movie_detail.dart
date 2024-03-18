import 'package:flutter/material.dart';

import 'movie_statusbar.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

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
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255))),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.keyboard_backspace_sharp),
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Poster của phim
            Stack(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 500,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        'https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais',
                        fit: BoxFit.cover,
                      ),
                    )),
                const Positioned(
                    bottom: 8, left: 65, right: 65, child: StatusBarDetail())
              ],
            ),
            // button play

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
