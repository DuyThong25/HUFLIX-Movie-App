import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_animated.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_backdrop.dart';

class CarouselMain extends StatefulWidget {
  const CarouselMain({super.key});

  @override
  State<CarouselMain> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselMain> {
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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: CarouselAnimated(),
        // body:  Column(
        //   children: [
        //     CarouselBackdrop(),
        //     // Title movie
        //     Expanded(child: Placeholder())
              
              
        //     ],
        //)
        );
  }
}

//  List listimage = [
//     "https://img.freepik.com/free-photo/nature-tranquil-beauty-reflected-calm-water-generative-ai_188544-12798.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/natures-beauty-reflected-tranquil-mountain-waters-generative-ai_188544-7867.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/snowy-mountain-peak-starry-galaxy-majesty-generative-ai_188544-9650.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/autumn-season-leafs-plant-scene-generative-ai_188544-7971.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/autumn-leaf-falling-revealing-intricate-leaf-vein-generated-by-ai_188544-9869.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/glowing-lines-human-heart-3d-shape-dark-background-generative-ai_191095-1435.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/neon-tropical-monstera-leaf-banner_53876-138943.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/vibrant-colors-flow-abstract-wave-pattern-generated-by-ai_188544-9781.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/nighttime-nature-landscape-galaxy-mountain-water-star-beauty-generative-ai_188544-9736.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/lake-mountains_1204-502.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//     "https://img.freepik.com/free-photo/vibrant-autumn-maple-leaves-nature-beauty-showcased-generated-by-ai_188544-15039.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais",
//   ];