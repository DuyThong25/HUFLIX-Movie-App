class Actor {
  int? id;
  String? name;
  String? department;
  String? characterName;
  String? profilePath;
  String? job;

  String? biography;
  String? birthday;
  String? placeOfBirth;

  Actor(
      {this.id,
      this.name,
      this.department,
      this.characterName,
      this.profilePath, 
      this.job,
      this.biography,
      this.birthday,
      this.placeOfBirth});

  Actor.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    department = json["known_for_department"];
    characterName = json["character"];
    profilePath = json["profile_path"];
    job = json["job"];
    biography = json["biography"];
    birthday = json["birthday"];
    placeOfBirth = json["place_of_birth"];
  }

  Actor.fromJsonForFirebase(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    department = json["department"];
    characterName = json["characterName"];
    profilePath = json["profilePath"];
    job = json["job"];
    biography = json["biography"];
    birthday = json["birthday"];
    placeOfBirth = json["placeOfBirth"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'characterName': characterName,
      'profilePath': profilePath,
      'job': job,
      'biography': biography,
      'birthday': birthday,
      'placeOfBirth': placeOfBirth
    };
  }


}
