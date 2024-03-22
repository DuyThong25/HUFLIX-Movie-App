import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../models/moviedetail.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  final _searchText = TextEditingController();
  // late List<Future<MovieDetailModel>> listMovie;
  late Future<List<MovieDetailModel>> _searchResults;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Gán vào mảng trỗng
    _searchResults = Future.value([]);
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
            FutureBuilder<List<MovieDetailModel>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: Colors.red.shade500,)),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(child: Text('Lỗi: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return  SliverFillRemaining(
                    child: Center(child: Text("Thử tìm phim khác nhé..", style: TextStyle(fontSize: 16, color: Colors.grey[850]),)),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].title!),
                          
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }

  void _onSearch(String input) {
    print(input);
    setState(() {
      _searchResults = Api().searchListByName(input);
    });
  }

  itemSearch() {}
}
