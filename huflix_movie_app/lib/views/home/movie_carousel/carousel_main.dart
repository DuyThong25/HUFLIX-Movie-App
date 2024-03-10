import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_animated.dart';

class CarouselMain extends StatelessWidget {
  const CarouselMain({super.key});

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
        leading: const Icon(Icons.menu),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: CarouselAnimated(),
    );
  }
}