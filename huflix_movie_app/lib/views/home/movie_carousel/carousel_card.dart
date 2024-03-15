import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.src, required this.movieTitle});
  final String src;
  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Image.network(
            fit: BoxFit.fitHeight,
            width: 260,
            height: 300,
            src,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Data movie
        Text(
          "${movieTitle}",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 6),
            height: 5,
            width: 100,
            decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.white38, offset: Offset(2, 2))
                ]))
      ],
    ));
  }
}
