import 'dart:ui';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    listData = [
      "https://img.freepik.com/free-photo/nature-tranquil-beauty-reflected-calm-water-generative-ai_188544-12798.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/natures-beauty-reflected-tranquil-mountain-waters-generative-ai_188544-7867.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/snowy-mountain-peak-starry-galaxy-majesty-generative-ai_188544-9650.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/autumn-season-leafs-plant-scene-generative-ai_188544-7971.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/autumn-leaf-falling-revealing-intricate-leaf-vein-generated-by-ai_188544-9869.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/glowing-lines-human-heart-3d-shape-dark-background-generative-ai_191095-1435.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/neon-tropical-monstera-leaf-banner_53876-138943.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/vibrant-colors-flow-abstract-wave-pattern-generated-by-ai_188544-9781.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/nighttime-nature-landscape-galaxy-mountain-water-star-beauty-generative-ai_188544-9736.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/lake-mountains_1204-502.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
      "https://img.freepik.com/free-photo/vibrant-autumn-maple-leaves-nature-beauty-showcased-generated-by-ai_188544-15039.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
    ];
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
            .map((item) => Container(
                      child: Stack(
                        children: <Widget>[
                          // Backdrop Background
                          Container(
                            child: CarouselBackdrop(src: item)
                          ),
                          // image card data
                          Positioned(
                              bottom: 0,
                              right: -50,
                              left: -50,
                              child: CarouselCard(src: item)),
                        ],
                      )))
            .toList());
  }
}
