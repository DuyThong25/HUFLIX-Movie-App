import 'package:flutter/material.dart';

class Common {
  static String shortenTitleCardCarousel(String title) {
    if (title.length <= 36) {
      return title;
    } else {
      
      return "${title.substring(0, 36)}...";
    }
  }
  static String shortenTitleTab(String title) {
    if (title.length <= 15) {
      return title;
    } else {
      return "${title.substring(0, 15)}...";
    }
  }

    static String shortenStringChar(String title, int numCharacter) {
    if (title.length <= numCharacter) {
      return title;
    } else {
      return "${title.substring(0, numCharacter)}...";
    }
  }



  static TextStyle styleDescriptionMovieDetail() {
    TextStyle style = const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400
    );
    return style;
  }

static String formatDuration(Duration duration) {
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return "${hours}g${minutes}p";
}

}