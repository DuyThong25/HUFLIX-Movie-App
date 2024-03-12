import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/model/videotest.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_card.dart';
import 'carousel_backdrop.dart';

class CarouselAnimated extends StatefulWidget {
  const CarouselAnimated({super.key});

  @override
  State<CarouselAnimated> createState() => _CarouselAnimatedState();
}

class _CarouselAnimatedState extends State<CarouselAnimated> {
  List<String> listData = [];

  @override
  void initState() {
    super.initState();
    listData = createDataTest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: slide(listData),
    );
  }

  Widget slide(List<String> listData) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: 500,
          disableCenter: false,
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        items: listData
            .map((item) => Stack(
              children: <Widget>[
                // Backdrop Background
                CarouselBackdrop(src: item),
                // image card data
                Positioned(
                    bottom: 5,
                    right: -50,
                    left: -50,
                    child: CarouselCard(src: item)),
              ],
            ))
            .toList());
  }
}
