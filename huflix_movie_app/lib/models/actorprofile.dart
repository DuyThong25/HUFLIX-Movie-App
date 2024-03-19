class ActorProfile {
  int? id;
  String? biography;
  String? birthday;
  String? name;
  String? profilePath;
  String? department;
  String? placeOfBirth;

  ActorProfile({this.id, this.biography, this.birthday, this.name, this.profilePath, this.department, this.placeOfBirth});

  ActorProfile.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    biography = json["biography"];
    birthday = json["birthday"];
    name = json["name"];
    profilePath = json["profile_path"];
    department = json["known_for_department"];
    placeOfBirth = json["place_of_birth"];
  }
}
