import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/views/detail/popup_infor_actor.dart';
import 'package:intl/intl.dart';

class MovieDetailActor extends StatelessWidget {
  const MovieDetailActor({super.key, required this.actorOfMovie});
  final List<Actor> actorOfMovie;
  // late Future<List<ActorProfile>> profileActorByID;

  @override
  Widget build(BuildContext context) {
    List<Actor>? actorList =
        actorOfMovie.where((item) => item.department == "Acting").toList();
    List<Actor>? crewList =
        actorOfMovie.where((item) => item.department != "Acting").toList();
    // Đưa direction lên đầu danh sách
    crewList.sort((a, b) {
      // So sánh tên công việc, đưa "Direction" lên đầu
      var jobA = a.department == "Directing" ? 0 : 1;
      var jobB = b.department == "Directing" ? 0 : 1;
      return jobA.compareTo(jobB);
    });
    // Loại bỏ các actor có trùng tên
    List<Actor> uniqueCrewList = [];
    Set<String> actorNames = {};
    for (var actor in crewList) {
      if (!actorNames.contains(actor.name)) {
        uniqueCrewList.add(actor);
        actorNames.add(actor.name!);
      }
    }
    double _heigtActorImage = 220;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // list of Actor
        SizedBox(
          height: _heigtActorImage,
          child: actorList.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: actorList.length,
                  itemBuilder: (context, index) {
                    return itemActor(actorList[index], context);
                  },
                )
              : const Center(
                  child: Text("Đang cập nhật..."),
                ),
        ),
        const SizedBox(
          height: 30,
        ),
        Divider(
          color: Colors.grey[900],
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Nhà sản xuất",
            style: TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // List of CREWS
        SizedBox(
            height: _heigtActorImage,
            child: uniqueCrewList.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: uniqueCrewList.length,
                    itemBuilder: (context, index) {
                      return itemNotActor(uniqueCrewList[index], context);
                    },
                  )
                : const Center(child: Text("Đang cập nhật...")))
      ],
    );
  }

  Widget itemActor(Actor actor, BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ShowInfoActor(actor: actor);
            },
          );
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.fromLTRB(0, 6, 50, 0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26)),
                    child: actor.profilePath != null
                        ? (Image.network(
                            actor.profilePath!,
                            width: 165,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/logo2.jpg',
                              width: 165,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ))
                        : Image.asset(
                            'assets/images/logo2.jpg',
                            width: 165,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ))),
            Positioned(
              bottom: -6,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 4, bottom: 6),
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
        ));
  }

  Widget itemNotActor(Actor crew, BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ShowInfoActor(actor: crew);
            },
          );
        },
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 6, 14, 6),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(26),
                                topRight: Radius.circular(26)),
                            child: crew.profilePath != null
                                ? (Image.network(
                                    crew.profilePath!,
                                    width: 165,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/logo2.jpg',
                                      width: 165,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                                : Image.asset(
                                    'assets/images/logo2.jpg',
                                    width: 165,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ))),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, top: 4, bottom: 24),
                          color: Colors.black54,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Text(
                                crew.job ?? 'Chưa cập nhật..',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16),
                                maxLines: 1,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crew.department ?? "Đang cập nhật",
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      crew.name ?? "Đang cập nhật..",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      crew.birthday != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(crew.birthday!))
                          : "Đang cập nhật..",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(crew.placeOfBirth ?? "Đang cập nhật..",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold)),
                  ],
                ))
              ],
            )));
  }
}
