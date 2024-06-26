// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:huflix_movie_app/firebase/firebase.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../detail/movie_detail.dart';
import 'carousel_backdrop.dart';

class CarouselAnimated extends StatefulWidget {
  const CarouselAnimated({super.key});

  @override
  State<CarouselAnimated> createState() => _CarouselAnimatedState();
}

class _CarouselAnimatedState extends State<CarouselAnimated> {
  late Future<List<Movie>> trendingMovies;
  // late Future<List<Actor>> actorOfMovie;
  // late Future<Movie> detailMovies;

  @override
  void initState() {
    super.initState();
    // trendingMovies = Api().getTrendingMovies();
    trendingMovies = MyFireStore().getTrendingMoviesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: trendingMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: slide(snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        // By default, show a loading spinner
        return LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 168, 2, 121), size: 50);
      },
    );
  }

  Widget slide(List<Movie> listMovies) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        // height: 520,
        disableCenter: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
      items: listMovies.map((movie) {
        return GestureDetector(
          onTap: () {
            setState(() {
              print(movie.id);
              // actorOfMovie = Api().actorFindByIdMovie(movie.id!);
              // detailMovies = Api().movieFindById(movie.id!) ;
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MovieDetailMain(
                    movie: movie,
                  ),
                ));
            });      
          },
          child: Stack(
            children: <Widget>[
              // Backdrop Background
              CarouselBackdrop(src: movie.backdropPath ?? ""),
              // image card data
              Positioned(
                bottom: 40,
                right: -50,
                left: -50,
                child: CarouselCard(
                  src: movie.posterPath!,
                  movieTitle: movie.title!,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
