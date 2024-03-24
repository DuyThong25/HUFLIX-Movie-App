import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/common/common.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:huflix_movie_app/views/detail/movie_detail.dart';
import 'package:intl/intl.dart';
import '../../api/api.dart';
import '../../models/moviedetail.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final _searchText = TextEditingController();
  // late List<Future<Movie>> listMovie;
  late Future<List<Movie>> _searchResults;

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
                    // hasScrollBody: false,
                    child: Center(
                        child: Text(
                      "Thử tìm phim khác nhé..",
                      style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                    )),
                  );
                } else {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột trên mỗi hàng
                      mainAxisSpacing: 26.0, // Khoảng cách giữa các hàng
                      crossAxisSpacing: 26.0, // Khoảng cách giữa các cột
                      childAspectRatio:
                          0.7, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi ô
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        Movie movieDetail = snapshot.data![index];
                        return itemSearch(movieDetail);
                      },
                      childCount: snapshot.data!.length, // Số lượng ô
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }

  Widget itemSearch(Movie movieDetail) {
    return InkWell(
      onTap: () {
        late Future<List<Actor>> actorOfMovie = Api().actorFindByIdMovie(movieDetail.id!);
        late Future<Movie> detailMovies =  Api().movieFindById(movieDetail.id!);
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MovieDetailMain(
                movie: movieDetail,
                detailMovie: detailMovies,
                actorOfMovieByID: actorOfMovie,
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
              child: movieDetail.posterPath != null
                  ? Image.network(
                      Constants.BASE_IMAGE_URL + movieDetail.posterPath!,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : Image.asset(
                      'assets/images/logo1.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
            ),
            Positioned(
              // bottom: 0,
              left: 0,
              right: 10,
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 8, left: 6, right: 6),
                height: MediaQuery.of(context).size.height,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      child: Text(
                        movieDetail.title!.toUpperCase() ?? "Đang cập nhật..",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          letterSpacing: 2,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    // Năm
                    Row(
                      children: [
                        movieDetail.releaseDate != null ||
                                movieDetail.releaseDate != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 6, right: 6, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.white)),
                                  child: Text(
                                    DateFormat('yyyy').format(DateTime.parse(
                                        movieDetail.releaseDate!)),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                          
                        const Spacer(),
                        movieDetail.voteAverage != null ||
                                movieDetail.releaseDate != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 6, right: 6, top: 4, bottom: 4),
                                  color: movieDetail.voteAverage! > 6
                                      ? Colors.green.shade500
                                      : Colors.red.shade500,
                                  child: Text(
                                    // "${movie.voteAverage} ",
                                    NumberFormat('##.#')
                                        .format(movieDetail.voteAverage),
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
                      height: 6,
                    ),
                    Text(
                      movieDetail.overview ?? "Đang cập nhật..",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        // letterSpacing: 2,
                      ),
                      maxLines: 5,
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
