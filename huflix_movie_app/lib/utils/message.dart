import 'dart:js';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';

class FirebaseMessage {
  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessage.requestPermission();
    final fCMToken = await _firebaseMessage.getToken();
    initPushNotifications();
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void handleMessage(RemoteMessage? mes) {
    if (mes == null) {
      return;
    }

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  Future<void> handleBackgroundMessage(RemoteMessage? mes) async {
    if (mes == null) {
      return;
    }

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
