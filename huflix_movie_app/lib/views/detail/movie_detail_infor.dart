import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/common/common.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:intl/intl.dart';

class InforMovie extends StatelessWidget {
  const InforMovie({super.key, required this.movie});

  final Movie movie;
  // final Future<Movie> movieDetail;

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(minutes: movie.time ?? 0);
    // Kiểm tra xem genres list có chứa phần tử không movie.voteCount
    // Nếu có rồi thì khi load lại thì không thêm vô nữa
    if (movie.genres!.isEmpty ||
        !movie.genres!.any((genre) => genre.name!.contains("votes"))) {
      movie.genres!.insert(
          0,
          Genre(
              id: movie.genres!.length + 2,
              name: "${movie.voteCount.toString()} votes"));
    }
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
            movie.status == 'Released'
                ? ClipRRect(
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
                    ))
                : const SizedBox.shrink(),
            SizedBox(
              width: movie.status == 'Released' ? 10 : 0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: movie.status != 'Released'
                    ? Colors.red.shade500
                    : Colors.green.shade500,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 4, bottom: 4),
                child: Text(
                  movie.status! == 'Released' ? "Đang chiếu" : "Sắp chiếu",
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
            movie.releaseDate != null && movie.releaseDate != ""
                ? ClipRRect(
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
                  )
                : const SizedBox.shrink(),
            // Thời gian của phim
            const SizedBox(
              width: 10,
            ),
            movie.status! == 'Released'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        Common.formatDuration(duration),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
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
            itemCount: movie.genres!.length,
            itemBuilder: (context, index) {
              return itemGenres(movie.genres![index]);
            },
          ),
        ),
      ],
    );
  }

  Widget itemGenres(Genre genre) {
    return Container(
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
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
