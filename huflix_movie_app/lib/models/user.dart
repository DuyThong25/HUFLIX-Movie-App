import 'package:firebase_auth/firebase_auth.dart';

class User {
  String? username;
  String? email;
  String? password;
  User({this.username, this.email, this.password});

    getCurrentUser() {
      if (FirebaseAuth.instance.currentUser != null) {
        return FirebaseAuth.instance.currentUser;
      }
      return null;
    }
}
