// ignore_for_file: avoid_print

import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/api/api.dart';
import 'package:huflix_movie_app/models/moviedetail.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

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

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  // Workmanager().cancelAll();
  await Workmanager().registerPeriodicTask(
      "upload-newmovie-to-firestore", "upload-newmovie-to-firestore",
      frequency: const Duration(minutes: 1440),
      constraints: Constraints(
        networkType: NetworkType.connected
      ),

      existingWorkPolicy: ExistingWorkPolicy.append);

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
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: const Color.fromRGBO(35, 31, 32, 1),
      ),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      print(taskName);
      print(ScheduledTask.taskName);

      switch (taskName) {
        case ScheduledTask.taskName:
          // Code xử lý
          print('${ScheduledTask.taskName} is running');
          await ScheduledTask.control(); 
          print('${ScheduledTask.taskName} completed successfully');

          break;
      }
      return Future.value(true);
    } catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  });
}

class ScheduledTask {
  static const String taskName = "upload-newmovie-to-firestore";

  static Future<void> control() async {
    if (Firebase.apps.isNotEmpty) {
      print('2: Firebase đã được khởi tạo: ${Firebase.apps[0].name}');
    } else {
      print('2: Firebase chưa được khởi tạo');
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
    }

    // add your control here
    DateTime now = DateTime.now();
    String currentDate = DateFormat('yyyy-MM-dd').format(now);
    String currentYear = DateFormat('yyyy').format(now);
    int page = 1; // chỉ lấy 20 phim mới ở trang đầu tiên

    List<Movie> listMovie =
        await Api().updateUpcomingMovies(page, currentYear, currentDate);
    await Movie().uploadNewMoviesToFirestore(listMovie);
  }
}
