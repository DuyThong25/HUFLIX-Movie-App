class Genre {
   int? id;
   String? name;

  Genre({required this.id, required this.name});

  Genre.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      name= json['name'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}