import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:intl/intl.dart';
import '../../api/api_constants.dart';
import '../../models/actordetail.dart';

class MovieDetailActor extends StatelessWidget {
  const MovieDetailActor({super.key, required this.actorOfMovieByID});
  final Future<List<Actor>> actorOfMovieByID;
  // late Future<List<ActorProfile>> profileActorByID;

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

  Widget actorList(List<Actor> allActors) {
    List<Actor> actorList = allActors.where((item) => item.department == "Acting").toList();
    List<Actor> crewList = allActors  .where((item) => item.profilePath != null && item.department != "Acting").toList();
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
    Future<List<ActorProfile>> profileActorByID = Api().actorInforFindByIdActor(uniqueCrewList);
     double _heigtActorImage = 220;


    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // list of Actor
        SizedBox(
          height: _heigtActorImage,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: actorList.length,
            itemBuilder: (context, index) {
              return itemActor(actorList[index]);
            },
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
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
         const SizedBox(
          height: 10,
        ),
        // List of CREWS
        SizedBox(
            height: _heigtActorImage,
            child: FutureBuilder<List<ActorProfile>>(
              future: profileActorByID,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return itemNotActor(snapshot.data![index], context);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                // By default, show a loading spinner
                return const CircularProgressIndicator();
              },
            )),
      ],
    );
  }

  Widget itemActor(Actor actor) {
    return Stack(
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
                        Constants.BASE_IMAGE_URL + actor.profilePath!,
                        width: 165,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
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
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 6),
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
    );
  }

  Widget itemNotActor(ActorProfile directionList, BuildContext context) {
    return  SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 6, 14, 6),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26)),
                        child: directionList.profilePath != null
                            ? (Image.network(
                                Constants.BASE_IMAGE_URL + directionList.profilePath!,
                                width: 165,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ))
                            : Image.asset(
                                'assets/images/logo2.jpg',
                                width: 165,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ))),
                Expanded(         
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 26,),
                      // Ngành
                      Text(directionList.department ?? "Đang cập nhật", style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 4,),
                      Text(directionList.name ?? "Đang cập nhật..", style: const TextStyle(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,),
                      const SizedBox(height: 4,),
                      Text(
                        directionList.birthday != null ? 
                        DateFormat('dd-MM-yyyy').format(DateTime.parse(directionList.birthday!))
                        : "Đang cập nhật..", 
                        style: const TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.bold),
                         overflow: TextOverflow.ellipsis, maxLines: 1,),
                      const SizedBox(height: 4,),
                      Text(directionList.placeOfBirth ?? "Đang cập nhật..", style: const TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.bold)),

                    ],
                  ) 
                   )
              ],
            )
    );
  }
}
