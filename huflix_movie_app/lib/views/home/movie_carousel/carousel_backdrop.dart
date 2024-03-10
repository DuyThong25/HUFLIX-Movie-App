import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_animated.dart';

class CarouselBackdrop extends StatefulWidget {
  const CarouselBackdrop({super.key});

  @override
  State<CarouselBackdrop> createState() => _CarouselBackdropState();
}

class _CarouselBackdropState extends State<CarouselBackdrop> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        children: [
          // blur background image
          Container(
            height: 320,
            color: Colors.green,
          ),
          // ignore: prefer_const_constructors
          Positioned(
            bottom: -100,
            right: -50,
            left: -50,
            // movie card 
            child: CarouselAnimated()
          ),
        ],
      ),
    );
  }
}
