import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/drawer/about/about.dart';
import 'package:huflix_movie_app/views/drawer/leaderboard/leaderboard.dart';
import 'package:huflix_movie_app/views/genres/movie_genres_list_name.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:huflix_movie_app/views/search/search_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final loginUser = FirebaseAuth.instance.currentUser!;

  late String name = "Đang tải...";
  late String address = "Đang tải...";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final loginUser = FirebaseAuth.instance.currentUser;
    if (loginUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(loginUser.uid)
          .get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        name = userData['name'];
        address = userData['address'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 0.7,
        child: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://didongviet.vn/dchannel/wp-content/uploads/2023/08/hinh-nen-3d-hinh-nen-iphone-dep-3d-didongviet@2x.jpg"),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                        child: Text(name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text(loginUser.email!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Phim yêu thích',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(
                    builder: (context) {
                      return  const SearchMain(isFavoriteWidget: true,);
                    },
                  ));
                },
              ),
              ListTile(
                title: const Text('Thể loại',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ListNameGenres()));
                },
              ),
              ListTile(
                title: const Text('Bảng xếp hạng',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LeaderboadrMovie()));
                },
              ),
              ListTile(
                title: const Text('Liên hệ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Về chúng tôi',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const AboutUs()));
                },
              ),
              ListTile(
                title: const Text('Đăng xuất',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  _removeRememberLogin();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ));
  }

  _removeRememberLogin() async {
    // Sử dụng Share Referenced
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("rememberLogin");
    prefs.remove("emailUser");
    prefs.remove("passwordUser");

    // print("Dữ liệu Preference 1 ${prefs.getBool('rememberLogin').toString()} ");
    // print("Dữ liệu Preference 2 ${prefs.getString('emailUser').toString()} ");
    // print(
    //     "Dữ liệu Preference 3 ${prefs.getString('passwordUser').toString()} ");
  }
}
