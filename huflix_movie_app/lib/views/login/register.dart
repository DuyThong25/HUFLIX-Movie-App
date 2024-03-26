import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:huflix_movie_app/views/login/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:huflix_movie_app/views/login/login.dart';
import 'package:huflix_movie_app/utils/form_container.dart';
import 'package:huflix_movie_app/utils/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  
  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _passwordConfirmController.text.trim()) {
      return true;
    }
    else {
      return false;
    }
  }

  Future addUserDetail(String uid,String hoVaTen, String email, String address) async {
    // thêm vào bảng users
    await FirebaseFirestore.instance.collection("users").doc(uid).set({
      'uid' : uid,
      'name': hoVaTen,
      'email' : email,
      'address': address
    });
  }

  Future _signUp() async {
    try {
      if (passwordConfirmed()) {
        if (_nameController.text.trim() != '' && _addressController.text.trim() != '' && _emailController.text.trim() != '' ) {
          // Tạo tài khoản đăng nhập
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(), 
            password: _passwordConfirmController.text.trim()
          );
          final user = userCredential.user;
          if (user != null ) {
            // Lấy id của người dùng được tạo
            String userId = user.uid!;
            // Tạo thông tin người dùng
            addUserDetail(
              userId,
              _nameController.text.trim(), 
              _emailController.text.trim(), 
              _addressController.text.trim()
            );
          }
          // Nếu đăng ký thành công, quay lại trang LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
        else {
          showToast(message: "Vui lòng nhập đầy đủ thông tin");
        }
      }
      else {
        showToast(message: "Nhập lại mật khẩu không khớp");
      }
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Nếu email đã tồn tại, hiển thị thông báo
       showToast(message: "Email đã tồn tại");
      } 
      else {
        // Xử lý các trường hợp lỗi khác (nếu có)
        showToast(message: "Lỗi${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Đăng nhập"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Đăng ký",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _nameController,
                hintText: "Họ và tên",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _addressController,
                hintText: "Địa chỉ",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Mật khẩu",
                isPasswordField: true,
              ),

              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordConfirmController,
                hintText: "Nhập lại Mật khẩu",
                isPasswordField: true,
              ),

              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap:  (){
                  _signUp();

                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp ? const CircularProgressIndicator(color: Colors.white,):const Text(
                    "Đăng ký",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Đã có tài khoản?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}