import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:intl/intl.dart';

import '../../models/movie.dart';

class InforMovie extends StatelessWidget {
  const InforMovie({super.key, required this.movie, required this.movieDetail});

  final Movie movie;
  final Future<MovieDetailModel> movieDetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieDetail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Duration duration = Duration(minutes: snapshot.data!.time!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  snapshot.data!.status == 'Released' ?     
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 4, bottom: 4),
                        color: movie.voteAverage! > 6
                            ? Colors.green.shade500
                            : Colors.red.shade500,
                        child: Text(
                          // "${movie.voteAverage} ",
                          NumberFormat('##.#').format(movie.voteAverage),
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )) : const SizedBox.shrink(),
                   SizedBox(
                    width: snapshot.data!.status == 'Released' ? 10 : 0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      color: snapshot.data!.status != 'Released'
                                  ? Colors.red.shade500
                                  : Colors.green.shade500,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      child: Text(
                        snapshot.data!.status! == 'Released'
                            ? "Đang chiếu"
                            : "Sắp chiếu",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Trạng thái của phim
                  const Spacer(),
                  // Nằm sản xuất phim
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        DateFormat('yyyy')
                            .format(DateTime.parse(movie.releaseDate!)),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Thời gian của phim
                  const SizedBox(
                    width: 10,
                  ), snapshot.data!.status! == 'Released' ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        formatDuration(duration),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ) : const SizedBox.shrink(),                
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 24,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.genres!.length,
                  itemBuilder: (context, index) {
                    return itemGenres(snapshot.data!.genres![index]);
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget itemGenres(Genre genre) {
    return 
    Container(
      margin: const EdgeInsets.only(right: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            color: Colors.grey.shade700,
            padding: const EdgeInsets.only(left: 10, right: 10),
            // margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Text(
              genre.name!.replaceAll(RegExp(r'Phim'), ''),
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

String formatDuration(Duration duration) {
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return "${hours}g${minutes}p";
}
