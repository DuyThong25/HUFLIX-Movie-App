import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:huflix_movie_app/views/login/register.dart';
import 'package:page_transition/page_transition.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyAuQNOCmDWpDb7qCqg9sucdIA8tjFDvksk",
          appId: "1:851079373356:android:f2bb7e5dccc85f8de72789",
          messagingSenderId: "851079373356",
          projectId: "huflix-movie-app",
          storageBucket: "huflix-movie-app.appspot.com",
        ))
      : await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          // nextScreen: const LoginPage(),
          nextScreen: const HomePage(),

          splashTransition: SplashTransition.slideTransition,
          // pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: const Color.fromRGBO(35, 31, 32, 1)),
      // HomePage(),
    );
  }
}
