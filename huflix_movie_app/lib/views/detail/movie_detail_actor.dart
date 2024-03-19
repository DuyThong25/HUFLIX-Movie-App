import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huflix_movie_app/models/actor.dart';
import '../../api/api_constants.dart';

class MovieDetailActor extends StatelessWidget {
  const MovieDetailActor({super.key, required this.actorOfMovieByID});
  final Future<List<Actor>> actorOfMovieByID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Actor>>(
      future: actorOfMovieByID,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return actorList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        // By default, show a loading spinner
        return const CircularProgressIndicator();
      },
    );
  }

  Widget actorList(List<Actor> actors) {
    print(actors.length);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            itemBuilder: (context, index) {
              return itemActor(actors[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget itemActor(Actor actor) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.fromLTRB(0, 6, 50, 6),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26)),
                child: actor.profilePath != null
                    ? (Image.network(
                        Constants.BASE_IMAGE_URL + actor.profilePath!,
                        width: 180,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ))
                    : Image.asset(
                        'assets/images/logo2.jpg',
                        width: 180,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ))),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 16),
              color: Colors.black54,
              margin: const EdgeInsets.only(right: 50),
              child: Column(
                children: [
                  Text(
                    actor.name ?? 'Chưa cập nhật..',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4,),
                   Text(
                    actor.characterName ?? 'Chưa cập nhật..',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15),
                    maxLines: 1,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
