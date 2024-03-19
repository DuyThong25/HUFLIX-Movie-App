import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/detail/movie_detail_description.dart';
import '../../api/api_constants.dart';
import '../../models/actor.dart';
import '../../models/movie.dart';
import 'movie_detail_actor.dart';
import 'movie_statusbar.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key, required this.movie, required this.actorOfMovieByID});
  final Movie movie;
  final Future<List<Actor>> actorOfMovieByID;

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
                    height: MediaQuery.of(context).size.height - 400 ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        // 'https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg?size=626&ext=jpg&ga=GA1.1.8332681.1703272078&semt=ais',
                        Constants.BASE_IMAGE_URL + movie.posterPath!,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter ,
                      ),
                    )),
                // status bar
                const Positioned(
                    bottom: 14, left: 65, right: 65, child: StatusBarDetail())
              ],
            ),
            // Container chứa Nội dung của movie detail
            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(6),
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // voting - time
                    // const Text(
                    //   "2018 - 1h30m"
                    // ),
                    // Description of the movie
                    MovieDetalDescription(
                      description:
                        //"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Can sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui.",
                        movie.overview!
                    ),
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
                    const SizedBox(height: 6,),
                    MovieDetailActor(actorOfMovieByID: actorOfMovieByID),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      color: Colors.green,
                    ),
                  ],
                )),
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
