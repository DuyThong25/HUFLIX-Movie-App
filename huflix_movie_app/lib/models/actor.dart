class Actor {
  int? id;
  String? name;
  String? department;
  String? characterName;
  String? profilePath;
  String? job;

  Actor(
      {this.id,
      this.name,
      this.department,
      this.characterName,
      this.profilePath, 
      this.job});

  Actor.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    department = json["known_for_department"];
    characterName = json["character"];
    profilePath = json["profile_path"];
    job = json["job"];
  }
}
