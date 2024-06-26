// ignore_for_file: avoid_print

import 'dart:async';

import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huflix_movie_app/firebase/firebase.dart';
import 'package:huflix_movie_app/models/genres.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/detail/movie_detail.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class MovieGenreDetail extends StatefulWidget {
  final int idGenres;
  final String nameGenres;

  const MovieGenreDetail({
    super.key,
    required this.idGenres,
    required this.nameGenres,
  });

  @override
  State<MovieGenreDetail> createState() => _MovieGenreDetailState();
}

class _MovieGenreDetailState extends State<MovieGenreDetail> {
  final _totalPage = 20;
  int _currentPage = 1;
  DocumentSnapshot? _lastDocument;

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    // ignore: no_leading_underscores_for_local_identifiers
    _pagingController.addPageRequestListener((_currentPage) {
      _fetchPage(_currentPage);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int current) async {
    try {
      List<Movie> newItems = [];
      // Nếu không phải trang đầu tiên, sử dụng lastDocument để xác định vị trí bắt đầu
      Query query = FirebaseFirestore.instance
          .collection("movies")
          .orderBy("popularity", descending: true)
          .orderBy("releaseDate", descending: true)
          .limit(50);
      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();
      for (var snapshot in querySnapshot.docs) {
        setState(() {
          _lastDocument = querySnapshot.docs.last;
        });
        final data = snapshot.data() as Map<String, dynamic>;
        var dataGenres = data['genres'] as List;
        var listGenres =
            dataGenres.map((genre) => Genre.fromJson(genre)).toList();

        // Kiểm tra nếu trong listGenres có tồn tại idGenres
        if (listGenres.any((genre) => genre.id == widget.idGenres)) {
          newItems.add(Movie.fromFirestore(data));
        }
      }

      final isLastPage = _totalPage < _currentPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _currentPage += 1;
        final nextPageKey = _currentPage;
        _pagingController.appendPage(newItems, nextPageKey);
        
      }
      print("Trang hiện tại $_currentPage");
      print("Tổng trang $_totalPage");
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: [
        SliverAppBar(
            iconTheme: const IconThemeData(size: 28),
            backgroundColor: Colors.black,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: Text(widget.nameGenres.replaceAll(RegExp(r'Phim'), ''),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 255, 255))),
            actions: [
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {},
              ),
            ]),
        // SizedBox(height: 10,),
        PagedSliverGrid<int, Movie>(
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: true,
          showNoMoreItemsIndicatorAsGridChild: true,
          shrinkWrapFirstPageIndicators: false,
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Số cột trên mỗi hàng
            mainAxisSpacing: 26.0, // Khoảng cách giữa các hàng
            crossAxisSpacing: 26.0, // Khoảng cách giữa các cột
            childAspectRatio:
                0.7, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi ô
          ),
          builderDelegate: PagedChildBuilderDelegate<Movie>(
            itemBuilder: (context, item, index) => itemMovie(
              item,
            ),
          ),
        ),
      ]),
      // body: renderData()

      // ]),
    );
  }

  Widget itemMovie(Movie movie) {
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
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Blur(
                blur: 2,
                colorOpacity: 0.01,
                borderRadius: BorderRadius.circular(16),
                child: movie.posterPath != null
                    ? Image.network(
                        movie.posterPath!,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/logo2.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      )
                    : Image.asset(
                        'assets/images/logo2.jpg',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
              ),
              Positioned(
                // bottom: 0,
                left: 0,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 8, left: 8, right: 8),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [            
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Text(
                          (movie.title != "" && movie.title != null)
                              ? movie.title!.toUpperCase()
                              : "Đang cập nhật..",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // Năm
                      Row(
                        children: [
                          movie.releaseDate != null && movie.releaseDate != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Text(
                                      DateFormat('yyyy').format(
                                          DateTime.parse(movie.releaseDate!)),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const Spacer(),
                          movie.voteAverage != null || movie.releaseDate != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 10, top: 4, bottom: 4),
                                    color: movie.voteAverage! > 6
                                        ? Colors.green.shade500
                                        : Colors.red.shade500,
                                    child: Text(
                                      // "${movie.voteAverage} ",
                                      NumberFormat('##.#')
                                          .format(movie.voteAverage),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              : const SizedBox.shrink()
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        movie.overview != ""
                            ? movie.overview!
                            : "Đang cập nhật..",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.justify,
                        maxLines: 4,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
// PagedGridView<int, Movie>(
//           showNewPageProgressIndicatorAsGridChild: false,
//           showNewPageErrorIndicatorAsGridChild: false,
//           showNoMoreItemsIndicatorAsGridChild: false,
//           pagingController: _pagingController,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 100 / 150,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             crossAxisCount: 3,
//           ),
//           builderDelegate: PagedChildBuilderDelegate<Movie>(
//             itemBuilder: (context, item, index) => itemMovie(item),
//           ),
//         )
