import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/firebase/firebase.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/detail/movie_detail.dart';
import 'package:huflix_movie_app/views/home/movie_carousel/carousel_backdrop.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LeaderboadrMovie extends StatefulWidget {
  const LeaderboadrMovie({super.key});

  @override
  State<LeaderboadrMovie> createState() => _LeaderboadrMovieState();
}

class _LeaderboadrMovieState extends State<LeaderboadrMovie> {
  late Future<List<Movie>> mostLikeMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostLikeMovies = MyFireStore().getTop10LikeFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: mostLikeMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.beat(
                      color: const Color.fromARGB(255, 168, 2, 121), size: 50));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Hiện đang cập nhật.."),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.all(0),
                  // alignment: Alignment.center,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return itemLeaderboardMovie(snapshot.data![index], index);
                    },
                  ),
                );
              }
            }
          },
        ));
  }

  Widget itemLeaderboardMovie(Movie movie, int index) {

    var srcWidth = MediaQuery.of(context).size.width;
    var srcHeightImageTop1 = MediaQuery.of(context).size.height - 500;
    String currentYear = DateFormat('yyyy').format(DateTime.now());
    String currentDay = DateFormat('dd').format(DateTime.now());
    String currentMonth = DateFormat('MM').format(DateTime.now());

    if (index == 0) {
      return InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MovieDetailMain(
                    movie: movie,
                  ),
                ));
          },
          child: srcWidth < 700
          ? Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                child: Image.network(
                  movie.backdropPath!,
                  height: srcHeightImageTop1,
                  width: srcWidth,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/logo1.jpg",
                    height: srcHeightImageTop1,
                    width: srcWidth,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 35,
                child: Container(
                  width: srcWidth,
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Top-10",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2),
                        softWrap: true,
                      ),
                      Spacer(),
                      Text(
                        "Ngày $currentDay tháng $currentMonth, $currentYear",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: -5,
                child: Container(
                  width: srcWidth,
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2),
                        softWrap: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: srcWidth - 150,
                            child: Text(
                              movie.title!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.green.shade800,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                  // or ClipRRect if you need to clip the content
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .green.shade800, // inner circle color
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${movie.likeCount} ",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Icon(
                                        Icons.thumb_up_off_alt,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ],
                                  ) // inner content
                                  ),
                            ),
                          ),
                          Positioned(
                            top: -3, 
                            right: 0,
                            child: Container(
                              
                              child: const Icon(
                                Icons.star, // Star icon
                                color: Colors.yellow,
                                size: 24.0, // Adjust the size as needed
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ) : // giao dien ngang
          Container(
            height: 300,
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
            children: [
              CarouselBackdrop(
                        src: movie.backdropPath!,
                      ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(0.0)),
                child: Image.network(
                  movie.backdropPath!,
                  height: srcHeightImageTop1 + 400,
                  width: srcWidth,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/logo1.jpg",
                    height: srcHeightImageTop1,
                    width: srcWidth,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 35,
                child: Container(
                  width: srcWidth,
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      const Text(
                        "Top-10",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2),
                        softWrap: true,
                      ),
                      Spacer(),
                      Text(
                        "Ngày $currentDay tháng $currentMonth, $currentYear",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: -5,
                child: Container(
                  width: srcWidth,
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2),
                        softWrap: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: srcWidth - 150,
                            child: Text(
                              movie.title!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.green.shade800,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                  // or ClipRRect if you need to clip the content
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .green.shade800, // inner circle color
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${movie.likeCount} ",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Icon(
                                        Icons.thumb_up_off_alt,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ],
                                  ) // inner content
                                  ),
                            ),
                          ),
                          Positioned(
                            top: -3, 
                            right: 0,
                            child: Container(
                              
                              child: const Icon(
                                Icons.star, // Star icon
                                color: Colors.yellow,
                                size: 24.0, // Adjust the size as needed
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          )
          
          );
    } else {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            movie.title ?? "Đang cập nhật..",
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          leading: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(
                  width: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: movie.backdropPath != null
                      ? Image.network(
                          movie.backdropPath!,
                          width: 70,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "assets/images/logo1.jpg",
                            width: 70,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        )
                      : Image.asset(
                          "assets/images/logo1.jpg",
                          width: 70,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                ),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${movie.likeCount} ",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    letterSpacing: 0),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 2,
              ),
              const Icon(
                Icons.thumb_up_off_alt,
                color: Colors.green,
                size: 16.0,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MovieDetailMain(
                    movie: movie,
                  ),
                ));
          },
        ),
      );
    }
  }
}
