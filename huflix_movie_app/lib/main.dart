import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Container(
            padding: EdgeInsets.all(10),
            color: const Color.fromRGBO(35, 31, 32, 1),
            child: Expanded(child: 
            Image.asset(
                'assets/images/logo1.jpg', 
                fit: BoxFit.cover,
              ),
            )
          ),
          splashIconSize: 500,
          nextScreen: const HomePage(),
          splashTransition: SplashTransition.slideTransition,
          // pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: const Color.fromRGBO(35, 31, 32, 1)),
      // HomePage(),
    );
  }
}
