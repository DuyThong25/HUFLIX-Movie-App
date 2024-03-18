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
}