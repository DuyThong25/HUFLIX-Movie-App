import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       body: Column(
        children: [
          Expanded(
              flex: 2,
              child: CarouselMain(),
          ),
           Expanded(
              flex: 1,
              child: Placeholder(),
          ),
        ],
       )
    );
  }
}