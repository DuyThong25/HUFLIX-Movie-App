import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/actor.dart';
import '../../api/api.dart';
import '../../api/api_constants.dart';
import '../../models/moviedetail.dart';
import '../detail/movie_detail.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final _searchText = TextEditingController();
  // late List<Future<Movie>> listMovie;
  late Future<List<Movie>> _searchResults;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Gán vào mảng trỗng
    _searchResults = Future.value([]);
  }

  void _onSearch(String input) {
    print(input);
    setState(() {
      _searchResults = Api().searchListByName(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(size: 28),
              backgroundColor: Colors.black,
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: true,
              title: const Text("HUFLIX",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 255, 255, 255))),
              actions: [
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {},
                ),
              ],
              bottom: AppBar(
                  // Ẩn nút back trên app bar
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  // Search Area
                  title: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: TextField(
                        onChanged: (value) {
                          _onSearch(value);
                        },
                        controller: _searchText,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                /* Clear the search field */
                                _searchText.clear();
                                _onSearch(_searchText.text);
                              },
                            ),
                            hintStyle: TextStyle(color: Colors.grey[850]),
                            hintText: 'Tìm kiếm...',
                            border: InputBorder.none),
                      ),
                    ),
                  )),
            ),
            FutureBuilder<List<Movie>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.red.shade500,
                    )),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Lỗi: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                        child: Text(
                      "Thử tìm phim khác nhé..",
                      style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                    )),
                  );
                } else {
                  return SliverFillRemaining(
                      // child: itemSearch(snapshot.data!),
                      child: CarouselSlider(
                    options: CarouselOptions(
                      // height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.85,
                      initialPage: 0,
                      reverse: false,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.vertical,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: snapshot.data!.map(
                      (element) {
                        bool isValid = false;
                        if (_currentIndex == snapshot.data!.indexOf(element)) {
                          isValid = true;
                        }
                        return itemSearch(element, isValid);
                      },
                    ).toList(),
                  ));
                }
              },
            ),
          ],
        ));
  }

  Widget itemSearch(Movie movieDetail, bool isValid) {
    return GestureDetector(
      onTap: () {
        late Future<List<Actor>> actorOfMovie =
              Api().actorFindByIdMovie(movieDetail.id!);
          late Future<Movie> detailMovies =
              Api().movieFindById(movieDetail.id!);
        // Movie movie = Movie(id: movieDetail.id, title: movieDetail.title, originalTitle: movieDetail.originalTitle, backdropPath: movieDetail.backdropPath, posterPath: movieDetail.posterPath, overview: movieDetail.overview, releaseDate: movieDetail.releaseDate, voteAverage: movieDetail.voteAverage, voteCount: movieDetail.voteCount);

        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) {
            return MovieDetailMain(movie: movieDetail, detailMovie: detailMovies, actorOfMovieByID: actorOfMovie);
          })
        );
      },
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Container(
                height: 550,
                child: movieDetail.posterPath != null
                    ? Image.network(
                        Constants.BASE_IMAGE_URL + movieDetail.posterPath!,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )
                    : Image.asset(
                        "assets/images/logo1.jpg",
                        fit: BoxFit.cover,
                      )),
          ),
          // isValid ?
          // Positioned(
          //     bottom: 0,
          //     right: 0,
          //     left: 0,
          //     child: Container(
          //       height: 550,
          //       color: Colors.black38,
          //       child: Column(
          //         children: [
          //           Text(
          //       movieDe.title!.toUpperCase(),
          //       style: const TextStyle(
          //         color: Colors.white,
          //         fontSize: 30,
          //         letterSpacing: 3,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //         ],
          //       ),
          //     )
          //   ) : const SizedBox.shrink()
        ]),
      ),
    ));
  }
}
