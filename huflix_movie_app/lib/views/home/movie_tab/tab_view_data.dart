import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/common/common.dart';

import '../../../models/moviedetail.dart';
import '../../detail/movie_detail.dart';

class TabViewData extends StatelessWidget {
  const TabViewData({super.key, required this.listData});

  final List<Movie> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listData.length,
        itemBuilder: (context, index) {
          return itemListview(listData[index], context);
        },
      ),
    );
  }

  Widget itemListview(Movie movie, BuildContext context) {
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
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.network(
                  movie.posterPath!,
                  width: 160,
                  height: 180,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/logo1.jpg",
                    width: 160,
                    height: 180,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Common.shortenTitleTab(movie.title!),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
