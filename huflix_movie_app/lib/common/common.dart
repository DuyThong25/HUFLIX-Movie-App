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

  static TextStyle styleDescriptionMovieDetail() {
    TextStyle style = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w400
    );
    return style;
  }


}