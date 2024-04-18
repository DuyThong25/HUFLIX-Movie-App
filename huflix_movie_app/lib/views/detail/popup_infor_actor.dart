// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:huflix_movie_app/models/actor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translator/translator.dart';

class ShowInfoActor extends StatelessWidget {
  const ShowInfoActor({super.key, required this.actor});
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVietnameseText(actor.biography ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Khi dữ liệu đã sẵn sàng, cập nhật biography và hiển thị AlertDialog
          String biography = snapshot.data ?? 'Đang cập nhật..';
          return _buildAlertDialog(biography);
        } else {
          // Hiển thị một spinner khi dữ liệu đang được tải
          return Center(
              child: LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 168, 2, 121), size: 50));
        }
      },
    );
  }

  Widget _buildAlertDialog(biography) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 12, 11, 11),
      contentTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white54,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      titleTextStyle: const TextStyle(
        letterSpacing: 3,
        fontSize: 30.0,
        color: Color.fromARGB(255, 210, 24, 10),
        fontWeight: FontWeight.bold,
      ),
      contentPadding: const EdgeInsets.only(top: 10.0),
      title: Container(
        alignment: Alignment.center,
        child: Text(
          actor.name!.toUpperCase() ?? "Đang cập nhật..",
          textAlign: TextAlign.center,
        ),
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              actor.biography!.isNotEmpty ? biography : "Đang cập nhật..",
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getVietnameseText(String input) async {
    final translator = GoogleTranslator();
    var vietnamText;
    // Passing the translation to a variable
    if (input.isNotEmpty) {
      vietnamText = await translator.translate(input, from: 'en', to: 'vi');
    }
    print('Translated: $vietnamText');
    return vietnamText.toString();
  }
}
