// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huflix_movie_app/utils/form_container.dart';
import 'package:huflix_movie_app/utils/toast.dart';
import 'package:huflix_movie_app/views/home/home_page.dart';
import 'package:huflix_movie_app/views/login/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:huflix_movie_app/views/login/forgot_passsword_page.dart';
import 'package:huflix_movie_app/views/login/register.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  bool _isRememberLogin = false;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRememberLogin();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: const Text("Đăng nhập"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đăng nhập".toUpperCase(),
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isRememberLogin,
                    onChanged: (value) {
                      setState(() {
                        _isRememberLogin = value!;
                      });
                      print("Gia tri thay doi $_isRememberLogin");
                    },
                  ),
                  const Text(
                    "Ghi nhớ đăng nhập",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ForgotPassswordPage();
                      }));
                    },
                    child: const Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _signIn(_emailController.text, _passwordController.text);
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning
                        ? LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 168, 2, 121), size: 50)
                        : const Text(
                            "Đăng nhập",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),                
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(195, 245, 152, 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Đăng ký",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Đăng nhập với Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(email, password) async {
    _loading();
    setState(() {
      _isSigning = true;
    });

    //  email = _emailController.text;
    //  password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "Đăng nhập thành công!!");
      
      // Nếu có user thì kiểm tra user có check lưu đăng nhập không và lưu vào Shared Referenced
      _checkRememberLogin(_isRememberLogin, email, password);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      showToast(message: "Sai email hoặc mật khẩu, vui lòng thử lại");
    }
  }

  Future addUserDetail(String uid, String hoVaTen, String email) async {
    // thêm vào bảng users
    await FirebaseFirestore.instance.collection("users").doc(uid).set(
        {'uid': uid, 'name': hoVaTen, 'email': email, 'address': "Chưa có"});
  }

  _signInWithGoogle() async {
    _loading();
    // ignore: no_leading_underscores_for_local_identifiers
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          String userID = user.uid; // Lấy UID của người dùng từ Authentication
          addUserDetail(
            userID,
            user.displayName!,
            user.email!,
          );
        }

        await _firebaseAuth.signInWithCredential(credential);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      showToast(message: "Vui lòng thử lại..");
      print("Lỗi xảy ra $e");
    }
  }

  // Kiểm tra có cần nhớ đăng nhập không
  _checkRememberLogin(
      bool isRememberLogin, String email, String password) async {
    if (isRememberLogin) {
      // Sử dụng Share Referenced
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('rememberLogin', isRememberLogin);
      prefs.setString('emailUser', email);
      prefs.setString('passwordUser', password);
      print("Dữ liệu Preference 1 ${prefs.getBool('rememberLogin').toString()} ");
      print("Dữ liệu Preference 2 ${prefs.getString('emailUser').toString()} ");
      print("Dữ liệu Preference 3 ${prefs.getString('passwordUser').toString()} ");
    }
  }

  _loadRememberLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRememberLogin = prefs.getBool('rememberLogin') ?? false;
    });
    if (_isRememberLogin) {
      String? email = prefs.getString('emailUser');
      String? password = prefs.getString('passwordUser');
      if (email != null && password != null) {
        _signIn(email, password);
      }
    }
  }
  
  _loading() {
//loading
    showDialog(
        context: context,
        builder: (context) {
          return Container(
              color: Colors.black,
              child: LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 168, 2, 121), size: 50),
              );
        });

  }
}
