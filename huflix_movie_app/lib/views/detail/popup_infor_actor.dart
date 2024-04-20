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
    double scrwidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _getVietnameseText(actor.biography ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Khi dữ liệu đã sẵn sàng, cập nhật biography và hiển thị AlertDialog
          String biography = snapshot.data ?? 'Đang cập nhật..';
          return _buildAlertDialog(biography, scrwidth);
        } else {
          // Hiển thị một spinner khi dữ liệu đang được tải
          return Center(
              child: LoadingAnimationWidget.beat(
                  color: const Color.fromARGB(255, 168, 2, 121), size: 50));
        }
      },
    );
  }

  Widget _buildAlertDialog(biography, srcWidth) {
    return Container(
      padding: srcWidth < 700
      ? const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 50)
      : const EdgeInsets.all(30),
      child: AlertDialog(
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
            Container(
              child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26)),
                        
                    child:
               actor.profilePath != null
          ? (Image.network(
                            actor.profilePath!,
                            width: 165,
                            height: 200,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/logo2.jpg',
                              width: 165,
                              height: 200,
                              fit: BoxFit.cover,
                              
                            ),
                          ))
                        : Image.asset(
                            'assets/images/logo2.jpg',
                            width: 165,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
            )),
            const SizedBox(height: 10,),
            Text(
              actor.biography!.isNotEmpty ? biography : "Đang cập nhật..",
            ),
          ],
        ),
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
