import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:huflix_movie_app/api/api_constants.dart';
import 'package:huflix_movie_app/common/common.dart';
import 'package:huflix_movie_app/firebase/firebase.dart';
import 'package:huflix_movie_app/views/detail/movie_detail.dart';
import 'package:intl/intl.dart';
import '../../api/api.dart';
import '../../models/moviedetail.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key, required this.isFavoriteWidget});
  final bool isFavoriteWidget;

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
    if (widget.isFavoriteWidget == false) {
      _searchResults = Future.value([]);
    } else {
      _searchResults =
          MyFireStore().getFavoriteMoviesFromFirestore_FutureBuilder();
    }
  }

  void _onSearch(String input) {
    print(input);
    setState(() {
      if (widget.isFavoriteWidget == false) {
        _searchResults =
            MyFireStore().getMoviesByNameFromFirestore(input, false);
      } else {
        _searchResults =
            MyFireStore().getMoviesByNameFromFirestore(input, true);
      }
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
                        child: Text( widget.isFavoriteWidget == false 
                      ? "Thử tìm phim khác nhé.." : "Bạn chưa thêm vào phim yêu thích nào !",
                      style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                    )),
                  );
                } else {
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột trên mỗi hàng
                      mainAxisSpacing: 20.0, // Khoảng cách giữa các hàng
                      crossAxisSpacing: 24.0, // Khoảng cách giữa các cột
                      childAspectRatio:
                          0.74, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi ô
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
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MovieDetailMain(
                  movie: movieDetail,
                ),
              )).then((value) {
            setState(() {
              _searchResults =
                  MyFireStore().getFavoriteMoviesFromFirestore_FutureBuilder();
            });
          });
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.network(
                  movieDetail.posterPath!,
                  width: 160,
                  height: 200,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/logo1.jpg",
                    width: 160,
                    height: 200,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 48,
                child: Text(
                  movieDetail.title!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
        );
  }
}
