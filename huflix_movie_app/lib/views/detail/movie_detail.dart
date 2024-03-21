import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/detail/movie_detail_description.dart';
import 'package:huflix_movie_app/views/detail/movie_detail_infor.dart';
import '../../api/api_constants.dart';
import '../../models/actor.dart';
import '../../models/movie.dart';
import 'movie_detail_actor.dart';
import 'movie_statusbar.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail(
      {super.key,
      required this.movie,
      required this.actorOfMovieByID,
      required this.detailMovie});
      
  final Movie movie;
  final Future<List<Actor>> actorOfMovieByID;
  final Future<MovieDetailModel> detailMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // backgroundColor: const Color(0x44000000),
        // title: const Text("HUFLIX",
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 30,
        //         color: Color.fromARGB(255, 255, 255, 255))),
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
                    height: MediaQuery.of(context).size.height - 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        // 'https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais',
                        Constants.BASE_IMAGE_URL + movie.posterPath!,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    )),
                // status bar - Fuunction Bar
                const Positioned(
                    bottom: 14, left: 65, right: 65, child: StatusBarDetail())
              ],
            ),
            // Container chứa Nội dung của movie detail
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // voting - time
                  InforMovie(
                    movie: movie,
                    movieDetail: detailMovie,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // Description of the movie
                  MovieDetalDescription(description: movie.overview!),
                  Divider(
                    color: Colors.grey[900],
                    height: 22,
                  ),
                  // Actor và Crew
                  const Text(
                    "Diễn viên",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  MovieDetailActor(actorOfMovieByID: actorOfMovieByID),
                //   Container(
                // height: MediaQuery.of(context).size.height,
                //     width: MediaQuery.of(context).size.width,
                //     // height: MediaQuery.of(context).size.height,
                //     color: Colors.green,
                //   ),
                ],
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   color: Colors.green,
            // ),
          ],
        ),
      ),
    );
  }

// Define the function
  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "${hours}g${minutes}p";
  }
}
