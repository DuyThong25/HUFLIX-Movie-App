import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/videotest.dart';

class MovieDetailActor extends StatelessWidget {
  MovieDetailActor({super.key});

  List<String> listActor = createDataTest();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 140,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: listActor.length,
            itemBuilder: (context, index) {
              return itemActorList(listActor[index]);
              // return Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [Text("Item $index")],
              // );
            },
          ),
        ),
      ],
    );
  }

  Widget itemActorList(String actor) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.fromLTRB(0, 6, 50, 6),
          child: Image.network(
            actor,
            width: 160,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 6,right: 6,top: 10,bottom: 10),
            color: Colors.black54,
            margin: const EdgeInsets.only(right: 50),
            child: const Text(
              "Ronaldo",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        )
      ],
    );
  }
}
