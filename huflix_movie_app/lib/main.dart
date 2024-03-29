import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:huflix_movie_app/views/login/register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          nextScreen: const LoginPage(),
          // nextScreen: const HomePage(),
          splashTransition: SplashTransition.slideTransition,
          // pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: const Color.fromRGBO(35, 31, 32, 1)),
      // HomePage(),
    );
  }
}
