
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/toast.dart';


class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'e=Email đã được sử dụng.');
      } else {
        showToast(message: 'xuất hiện lỗi: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(message: 'Không tìm thấy người dùng');
      }else if(e.code == 'wrong-password' || e.code == "invalid-credential") {
        showToast(message: 'Sai mật khẩu.');
      }else if(e.code == "invalid-email"){
        showToast(message: 'Sai định dạng Email');
      }
      else if(e.code == "channel-error"){
        showToast(message: 'Vui lòng không bỏ trống.');
      }
      else {
        // showToast(message: 'lỗi xãy ra: ${e.code}');
      print("lỗi xãy ra: ${e.code}");
      }

    }
    return null;

  }




}