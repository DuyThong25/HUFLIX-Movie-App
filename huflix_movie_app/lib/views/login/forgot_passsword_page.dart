import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPassswordPage extends StatefulWidget {
  const ForgotPassswordPage({super.key});

  @override
  State<ForgotPassswordPage> createState() => _ForgotPassswordPageState();
}

class _ForgotPassswordPageState extends State<ForgotPassswordPage> {

  final _emailController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
  
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text("Đường dẫn reset mật khẩu đã gửi đến email đến bạn, vui lòng kiểm tra"),
            
          );
        }
      );
    } on FirebaseAuthException catch(e) {
      print(e);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Nhập email cần reset mật khẩu", style: TextStyle(fontSize: 22),),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12)
                ),
                hintText: "Email",
                fillColor: Colors.grey[200],
                filled: true
              ),
            ),
          ),
          const SizedBox(height: 12,),
          MaterialButton(
            onPressed: passwordReset,
            child: Text("Reset mật khẩu", style: TextStyle(color: Colors.white),),
            color: Colors.blue,
          )
        ],
      ),
    );
  }

}