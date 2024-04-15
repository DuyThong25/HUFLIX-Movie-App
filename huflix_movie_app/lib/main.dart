// ignore_for_file: avoid_print

import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:intl/intl.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyChKuWMuJHoYxZU8-iGQKvZzfcRx_3mbsw",
          appId: "1:889562453557:android:5f6b048315f51e16e1837c",
          messagingSenderId: "889562453557",
          projectId: "huflix-movie-app-61260",
          storageBucket: "huflix-movie-app-61260.appspot.com",
        ))
      : await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(now);
    String currentYear = DateFormat('yyyy').format(now);
    int page = 1; // chỉ lấy 20 phim mới ở trang đầu tiên
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Màn hình splash screen
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Container(
              padding: const EdgeInsets.all(10),
              color: const Color.fromRGBO(35, 31, 32, 1),
              child: Expanded(
                child: Image.asset( 
                  'assets/images/logo1.jpg',
                  fit: BoxFit.cover,
                ),
              )),
          splashIconSize: 500,
          nextScreen: FutureBuilder(
            future: Api().updateUpcomingMovies(page, currentYear, currentDate), // Gọi API để lấy danh sách phim mới
            builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                // Load dữ liệu từ API để lấy các phim mới và cập nhật lên FireStore 
                Movie().uploadNewMoviesToFirestore(snapshot.data!); 
                
                return const LoginPage(); 
              } else {
                print("**Lỗi Error: ${snapshot.error}");
                return const LoginPage();
              }
            },
        ),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: const Color.fromRGBO(35, 31, 32, 1),
      ),
    );
  }
}
