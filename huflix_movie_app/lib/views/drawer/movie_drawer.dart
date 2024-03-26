import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/genres/movie_genres.dart';
import 'package:huflix_movie_app/views/genres/movie_genres_list_name.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.7,
        child: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://didongviet.vn/dchannel/wp-content/uploads/2023/08/hinh-nen-3d-hinh-nen-iphone-dep-3d-didongviet@2x.jpg"),
                    ),
                    SizedBox(height: 10),
                    Expanded(child: Text("Admin", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    Expanded(child: Text("admin@gmail.com", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Phim yêu thích', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
               ListTile(
                title: const Text('Thể loại', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ListNameGenres()
                ));   
                },
              ),
              ListTile(
                title: const Text('Liên hệ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Về chúng tôi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Đăng xuất', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }
}
