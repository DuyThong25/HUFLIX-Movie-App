import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/views/genres/movie_genres.dart';

class ListNameGenres extends StatelessWidget {
  final Future<List<Genre>> _listGenres;
  ListNameGenres({super.key}) : _listGenres = Api().getListGenres();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(size: 28),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.keyboard_backspace_sharp),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: const Text(
            "Thể loại phim",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                color: Colors.black,
                iconSize: 38,
                icon: const Icon(Icons.favorite_border))
          ],
        ),
        body: FutureBuilder(
          future: _listGenres,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "Thử tìm phim khác nhé..",
                style: TextStyle(fontSize: 16, color: Colors.grey[850]),
              ));
            } else {
              return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 150),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => MovieGenreDetail(
                                      idGenres: snapshot.data![index].id!,
                                      nameGenres:
                                          snapshot.data![index].name!)));
                        },
                        child: Card(
                          // shadowColor: const Color.fromARGB(255, 128, 10, 2),
                          // shadowColor: Colors.amber,
                          // elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          margin: const EdgeInsets.all(10),
                          color: Colors.black,
                          key: ValueKey(snapshot.data![index].id),
                          child:
                              // height: Random().nextInt(150) + 20,
                              Center(
                            child: Text(
                              snapshot.data![index].name!
                                  .replaceAll(RegExp(r'Phim'), ''),
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ));
                  });
            }
          },
        ));
  }
}
