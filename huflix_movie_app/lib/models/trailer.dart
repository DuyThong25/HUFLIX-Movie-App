class Trailer {
  int? id;
  List<TrailerResult>? results;

  Trailer({this.id, this.results});

  factory Trailer.fromJson(Map<String,dynamic> json) {
    return Trailer(
      id: json['id'],
      results: List<TrailerResult>.from(json['results'].map((result) => TrailerResult.fromJson(result))),
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'results': results!.map((result) => result.toJson()).toList(),  
    };
  }
}

class TrailerResult {
  String iso6391;
  String iso31661;
  String name;
  String key;
  String publishedAt;
  String site;
  int size;
  String type;
  bool official;
  String resultId;

  TrailerResult({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.resultId,
  });

  factory TrailerResult.fromJson(Map<String, dynamic> json) {
    return TrailerResult(
      iso6391: json['iso_639_1'],
      iso31661: json['iso_3166_1'],
      name: json['name'],
      key: json['key'],
      publishedAt: json['published_at'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      resultId: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'iso6391': iso6391,
      'iso31661': iso31661,
      'name': name,
      'key': key,
      'publishedAt': publishedAt,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'resultId': resultId
    };
  }
}