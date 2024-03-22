import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_card.dart';
import '../../detail/movie_detail.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'carousel_backdrop.dart';

class CarouselAnimated extends StatefulWidget {
  const CarouselAnimated({super.key});

  @override
  State<CarouselAnimated> createState() => _CarouselAnimatedState();
}

class _CarouselAnimatedState extends State<CarouselAnimated> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Actor>> actorOfMovie;
  late Future<Movie> detailMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
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
        return const CircularProgressIndicator();
      },
    );
  }

  Widget slide(List<Movie> trendingMovies) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: 500,
        disableCenter: false,
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
      items: trendingMovies.map((movie) {
        return GestureDetector(
          onTap: () {
            setState(() {
              print(movie.id);
              actorOfMovie = Api().actorFindByIdMovie(movie.id!);
              detailMovies = Api().movieFindById(movie.id!) ;
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MovieDetailMain(
                    movie: movie,
                    detailMovie: detailMovies,
                    actorOfMovieByID: actorOfMovie,
                  ),
                ));
            });      
          },
          child: Stack(
            children: <Widget>[
              // Backdrop Background
              CarouselBackdrop(
                  src: Constants.BASE_IMAGE_URL + movie.backdropPath!),
              // image card data
              Positioned(
                bottom: 0,
                right: -50,
                left: -50,
                child: CarouselCard(
                  src: Constants.BASE_IMAGE_URL + movie.posterPath!,
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
