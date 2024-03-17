import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/common/common.dart';
import 'package:huflix_movie_app/models/movie.dart';

class TabViewData extends StatelessWidget {
  const TabViewData({Key? key, required this.listData}) : super(key: key);
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
          return itemListview(listData[index]);
        },
      ),
    );
  }

  Widget itemListview(Movie movie) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 30, left: 30, bottom: 12, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Image.network(
              Constants.BASE_IMAGE_URL + movie.posterPath!,
              width: 160,
              height: 180,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Text(
          Common.shortenTitle(movie.title!),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        )
      ],
    );
  }
}
