class Common {
  static String shortenTitle(String title) {
    if (title.length <= 15) {
      return title;
    } else {
      return title.substring(0, 15) + "...";
    }
  }
}