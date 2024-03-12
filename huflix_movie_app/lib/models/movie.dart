class Movie {
    int? id;
    String? title;
    String? originalTitle;
    String? backdropPath;
    String? posterPath;
    String? overview;
    String? releaseDate;
    double? voteAverage;
    int? voteCount;

    Movie({
      required this.id,
      required this.title,
      required this.originalTitle,
      required this.backdropPath,
      required this.posterPath,
      required this.overview,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount
    });


    factory Movie.fromJson(Map<String,dynamic> json) {
      return Movie(
        id: json["id"], 
        title: json["title"], 
        originalTitle: json["original_title"], 
        backdropPath: json["backdrop_path"], 
        posterPath: json["poster_path"], 
        overview: json["overview"], 
        releaseDate: json["release_date"], 
        voteAverage: json["vote_average"], 
        voteCount: json["vote_count"]
      );
    }
}

